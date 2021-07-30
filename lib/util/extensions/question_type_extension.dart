import 'package:quizmate_flutter/models/util/question_type.dart';

extension QuestionTypeExtension on QuestionType {
  /// Returns a String value based on the type value
  String get stringValue {
    switch (this) {
      case QuestionType.multiple:
        return 'Multiple choice questions';
      case QuestionType.boolean:
        return 'True/False questions';
      default:
        return 'Any question type';
    }
  }
}
