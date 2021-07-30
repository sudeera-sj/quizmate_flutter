import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/category/category_bloc.dart';
import 'package:quizmate_flutter/bloc/category/category_state.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/util/question_difficulty.dart';
import 'package:quizmate_flutter/models/util/question_type.dart';
import 'package:quizmate_flutter/ui/components/rounded_button.dart';
import 'package:quizmate_flutter/ui/screens/quiz.dart';
import 'package:quizmate_flutter/util/extensions/question_difficulty_extension.dart';
import 'package:quizmate_flutter/util/extensions/question_type_extension.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// This screen provides the user with a set of options to customize a quiz.
/// Includes the number of questions, quiz category, difficulty level and question type.
class QuizCreator extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const QuizCreator._());

  const QuizCreator._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create a quiz',
                    style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 48),
                  const Text('Question count'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<QuizBloc, QuizState>(
                buildWhen: (previous, current) => previous.count != current.count,
                builder: (context, quizState) {
                  return SfSlider(
                    activeColor: theme.primaryColor,
                    inactiveColor: theme.primaryColor,
                    min: 10,
                    max: 30,
                    value: quizState.count,
                    interval: 5,
                    stepSize: 5,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 0,
                    onChanged: (value) => quizBloc.setCount(value.toInt()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    buildWhen: (previous, current) => previous.categories != current.categories,
                    builder: (context, categoryState) {
                      return BlocBuilder<QuizBloc, QuizState>(
                        buildWhen: (previous, current) => previous.category != current.category,
                        builder: (context, quizState) {
                          return DropdownSearch<Category>(
                            mode: Mode.DIALOG,
                            label: "Quiz category",
                            onFind: (_) async => categoryState.categories,
                            itemAsString: (category) => category.name,
                            onChanged: (category) => quizBloc.setCategory(category!),
                            selectedItem: quizState.category,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<QuizBloc, QuizState>(
                    buildWhen: (previous, current) => previous.difficulty != current.difficulty,
                    builder: (context, quizState) {
                      return DropdownSearch<QuestionDifficulty>(
                        mode: Mode.DIALOG,
                        maxHeight: 240,
                        label: "Quiz difficulty",
                        onFind: (_) async => QuestionDifficulty.values,
                        itemAsString: (difficulty) => difficulty.stringValue,
                        onChanged: (difficulty) => quizBloc.setDifficulty(difficulty!),
                        selectedItem: quizState.difficulty,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<QuizBloc, QuizState>(
                    buildWhen: (previous, current) => previous.type != current.type,
                    builder: (context, quizState) {
                      return DropdownSearch<QuestionType>(
                        mode: Mode.DIALOG,
                        maxHeight: 192,
                        label: "Quiz type",
                        onFind: (_) async => QuestionType.values,
                        itemAsString: (type) => type.stringValue,
                        onChanged: (type) => quizBloc.setType(type!),
                        selectedItem: quizState.type,
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundedButton.filled(
                        label: "Create quiz",
                        onPressed: () {
                          quizBloc.createQuiz();
                          Navigator.of(context).push(Quiz.route());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
