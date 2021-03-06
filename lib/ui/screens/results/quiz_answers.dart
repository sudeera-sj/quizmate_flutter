import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/ui/sub_components/answer_view.dart';

/// This screen displays the answers to the quiz and compares them with the answers provided by the user.
class QuizAnswers extends StatelessWidget {
  const QuizAnswers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24),
              child: Text(
                'Your answers',
                style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<QuizBloc, QuizState>(
              builder: (_, state) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.questions.length,
                  itemBuilder: (_, index) => AnswerView(index, state.questions[index]),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
