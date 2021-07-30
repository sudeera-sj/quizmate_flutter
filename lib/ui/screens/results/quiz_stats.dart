import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/models/data/question.dart';
import 'package:quizmate_flutter/models/util/pie_chart_data.dart';
import 'package:quizmate_flutter/util/extensions/duration_extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// This screen displays a collection of statistics about the completed quiz.
/// Includes when the quiz was started and submitted, total duration taken to complete the quiz,
/// a pie chart representing how the user has faced the quiz and finally,
/// a score based on the number of correct answers.
class QuizStats extends StatelessWidget {
  const QuizStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (_, state) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz statistics',
                    style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Quiz started on',
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat("dd-MM-yyyy 'at' h:mm a").format(state.start!),
                    style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Quiz finished on',
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat("dd-MM-yyyy 'at' h:mm a").format(state.end!),
                    style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Quiz duration',
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.end!.difference(state.start!).formattedValue,
                    style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 24),
                  _AnswerChart(state.questions),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your score',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline5,
                        ),
                        Text(
                          _calculateFinalScore(state.questions),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColorLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _calculateFinalScore(List<Question> questions) {
    return NumberFormat.decimalPercentPattern(decimalDigits: 2).format(
      questions.where((e) => e.givenAnswer == e.correctAnswer).length / questions.length,
    );
  }
}

/// Shows a chart visualizing how the user has answered the quiz.
class _AnswerChart extends StatelessWidget {
  final List<Question> _questions;

  const _AnswerChart(this._questions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SfCircularChart(
          title: ChartTitle(text: ''),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
          ),
          series: <PieSeries<PieChartData, String>>[
            PieSeries<PieChartData, String>(
              dataSource: _createChartData(),
              xValueMapper: (data, _) => data.xValue,
              yValueMapper: (data, _) => data.yValue,
              dataLabelMapper: (data, _) => data.xValue,
              pointColorMapper: (data, _) => data.colorValue,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartData> _createChartData() {
    final List<PieChartData> chartData = [];

    int unansweredCount = 0;
    int correctCount = 0;
    int incorrectCount = 0;

    _questions.forEach((element) {
      if (element.givenAnswer.isEmpty) {
        unansweredCount++;
      } else if (element.givenAnswer == element.correctAnswer) {
        correctCount++;
      } else {
        incorrectCount++;
      }
    });

    if (unansweredCount > 0) {
      chartData.add(PieChartData('Unanswered', unansweredCount, Colors.orange));
    }

    if (correctCount > 0) {
      chartData.add(PieChartData('Correct', correctCount, Colors.green));
    }

    if (incorrectCount > 0) {
      chartData.add(PieChartData('Incorrect', incorrectCount, Colors.red));
    }

    return chartData;
  }
}
