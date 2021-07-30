import 'package:flutter/material.dart';
import 'package:quizmate_flutter/models/data/question.dart';

/// This component is used to present how the user has answered a particular question.
///
///
/// If the answer is correct, the background would be in green color.
///
/// If the answer is incorrect, the background will be in crimson color.
///
/// If the user hasn't answered the question, the background will be in dark orange color.
class AnswerView extends StatelessWidget {
  final int _index;
  final Question _question;

  const AnswerView(this._index, this._question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: _getCardColor(),
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
                style: textTheme.caption!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                _question.text,
                style: textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Correct answer',
                style: textTheme.caption!.copyWith(color: Colors.white),
              ),
              Text(
                _question.correctAnswer,
                style: textTheme.subtitle2!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Your answer',
                style: textTheme.caption!.copyWith(color: Colors.white),
              ),
              Text(
                _question.givenAnswer.isNotEmpty ? _question.givenAnswer : '---',
                style: textTheme.subtitle2!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns a color based on the given answer to the question.
  ///
  /// Green if correct, Red if incorrect and orange if unanswered
  Color _getCardColor() {
    if (_question.givenAnswer.isEmpty) {
      return Colors.orange;
    } else if (_question.givenAnswer == _question.correctAnswer) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
