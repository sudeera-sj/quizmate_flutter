import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/ui/screens/results/quiz_answers.dart';
import 'package:quizmate_flutter/ui/screens/results/quiz_stats.dart';

/// The screen that contains the answers view and the statistics view
class QuizResults extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const QuizResults._());

  const QuizResults._({Key? key}) : super(key: key);

  @override
  _QuizResultsState createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          _onItemTapped(0);
          return false;
        }

        final quizBloc = BlocProvider.of<QuizBloc>(context);

        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Going back'),
            content: const Text('This will end the current quiz. Are you sure to proceed ?'),
            actions: [
              TextButton(
                child: Text(
                  'No',
                  style: theme.textTheme.bodyText2,
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: Text(
                  'Yes',
                  style: theme.textTheme.bodyText2,
                ),
                onPressed: () {
                  quizBloc.endQuiz();
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );

        return shouldPop ?? false;
      },
      child: Scaffold(
        body: _selectedIndex == 0 ? const QuizAnswers() : const QuizStats(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_rounded),
              label: 'Answers',
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.pie_chart_rounded),
              label: 'Statistics',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
