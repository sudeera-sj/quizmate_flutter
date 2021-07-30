import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/models/data/question.dart';

/// Created by Sudeera Sandaruwan
class QuestionView extends StatelessWidget {
  final int _index;
  final Question _question;

  const QuestionView(this._index, this._question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question no. ${_index + 1}',
                style: textTheme.caption,
              ),
              const SizedBox(height: 8),
              Text(
                _question.text,
                style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              _QuestionAnswers(_index, _question),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionAnswers extends StatelessWidget {
  final int _index;
  final Question _question;

  const _QuestionAnswers(this._index, this._question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    final answers = _question.allAnswers;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (context, index) {
        return RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          title: Text(
            answers[index],
            style: Theme.of(context).textTheme.bodyText2,
          ),
          value: answers[index],
          groupValue: _question.givenAnswer,
          onChanged: (_) => quizBloc.answerQuestion(_index, index),
        );
      },
    );
  }
}
