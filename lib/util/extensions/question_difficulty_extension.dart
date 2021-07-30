import 'package:quizmate_flutter/models/util/question_difficulty.dart';

extension QuestionDifficultyExtension on QuestionDifficulty {
  String get stringValue {
    switch (this) {
      case QuestionDifficulty.easy:
        return 'Easy';
      case QuestionDifficulty.medium:
        return 'Medium';
      case QuestionDifficulty.hard:
        return 'Hard';
      default:
        return 'Any difficulty';
    }
  }
}
