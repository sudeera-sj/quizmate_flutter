import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/data/question.dart';
import 'package:quizmate_flutter/models/util/question_difficulty.dart';
import 'package:quizmate_flutter/models/util/question_type.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

class QuizState {
  static const QuizState initialState = QuizState(TaskProgress.idle, 10, Category.defaultCategory,
      QuestionDifficulty.any, QuestionType.any, [], null, null);

  final TaskProgress progress;
  final int count;
  final Category category;
  final QuestionDifficulty difficulty;
  final QuestionType type;
  final List<Question> questions;
  final DateTime? start;
  final DateTime? end;

  const QuizState(this.progress, this.count, this.category, this.difficulty, this.type,
      this.questions, this.start, this.end);

  QuizState copyWith({
    TaskProgress? progress,
    int? count,
    Category? category,
    QuestionDifficulty? difficulty,
    QuestionType? type,
    List<Question>? questions,
    DateTime? start,
    DateTime? end,
  }) {
    if ((progress == null || identical(progress, this.progress)) &&
        (count == null || identical(count, this.count)) &&
        (category == null || identical(category, this.category)) &&
        (difficulty == null || identical(difficulty, this.difficulty)) &&
        (type == null || identical(type, this.type)) &&
        (questions == null || identical(questions, this.questions)) &&
        (start == null || identical(start, this.start)) &&
        (end == null || identical(end, this.end))) {
      return this;
    }

    return new QuizState(
      progress ?? this.progress,
      count ?? this.count,
      category ?? this.category,
      difficulty ?? this.difficulty,
      type ?? this.type,
      questions ?? this.questions,
      start ?? this.start,
      end ?? this.end,
    );
  }
}
