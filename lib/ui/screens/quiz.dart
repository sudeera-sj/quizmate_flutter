import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/models/data/question.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';
import 'package:quizmate_flutter/ui/components/rounded_button.dart';
import 'package:quizmate_flutter/ui/screens/results/quiz_results.dart';
import 'package:quizmate_flutter/ui/sub_components/question_view.dart';

/// This screen displays the created quiz to the user.
/// The user can then select the answers or leave them blank if preferred, and proceed to submit the quiz.
class Quiz extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const Quiz._());

  const Quiz._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        final quizBloc = BlocProvider.of<QuizBloc>(context);
        final theme = Theme.of(context);

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
        body: Container(
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (_, state) {
              switch (state.progress) {
                case TaskProgress.success:
                  if (state.questions.isNotEmpty) {
                    return _QuestionList(state.questions);
                  } else {
                    return const _EmptyView();
                  }
                case TaskProgress.error:
                  return const _ErrorView();
                default:
                  return const _LoadingView();
              }
            },
          ),
        ),
      ),
    );
  }
}

/// This view is shown until the request to fetch the quiz is resolved
class _LoadingView extends StatelessWidget {
  const _LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            value: null,
          ),
          const SizedBox(height: 16),
          Text(
            'Setting things up',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

/// Once a quiz with a set of questions are successfully fetched from the API, this view is displayed.
class _QuestionList extends StatelessWidget {
  final List<Question> _questions;

  const _QuestionList(this._questions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    final theme = Theme.of(context);

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 24),
          child: Text(
            'Here we go!',
            style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 24),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _questions.length,
          itemBuilder: (_, index) => QuestionView(index, _questions[index]),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundedButton.filled(
                label: "Submit answers",
                onPressed: () async {
                  final shouldSubmit = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Submit quiz'),
                      content: const Text('Are you sure to submit the quiz and view your score ?'),
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
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ],
                    ),
                  );

                  if (shouldSubmit!) {
                    quizBloc.submitQuiz();
                    Navigator.pushReplacement(context, QuizResults.route());
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// If the returned quiz contains no questions, this view is displayed.
class _EmptyView extends StatelessWidget {
  const _EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Oops!',
            textAlign: TextAlign.center,
            style: textTheme.headline3,
          ),
          const SizedBox(height: 16),
          Text(
            'turns out, we don\'t have that many questions with us just yet.',
            textAlign: TextAlign.center,
            style: textTheme.headline6,
          ),
          const SizedBox(height: 16),
          Text(
            'try lowering the number of questions',
            textAlign: TextAlign.center,
            style: textTheme.subtitle1,
          ),
          const SizedBox(height: 32),
          RoundedButton.filled(
            label: "Go back",
            onPressed: () {
              quizBloc.endQuiz();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

/// If the request to fetch the quiz was unsuccessful, this view is displayed.
class _ErrorView extends StatelessWidget {
  const _ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Oops! An error occurred',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          RoundedButton.filled(
            label: "Try again",
            onPressed: () => quizBloc.createQuiz(),
          ),
        ],
      ),
    );
  }
}
