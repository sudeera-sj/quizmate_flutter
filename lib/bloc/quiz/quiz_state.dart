import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/data/question.dart';
import 'package:quizmate_flutter/models/util/question_difficulty.dart';
import 'package:quizmate_flutter/models/util/question_type.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

/// The state for category related operations
class QuizState {
  static const QuizState initialState = QuizState(TaskProgress.idle, 10, Category.defaultCategory,
      QuestionDifficulty.any, QuestionType.any, [], null, null);

  /// The progress of fetching a quiz from the API
  final TaskProgress progress;

  /// Maximum number of questions to be in the quiz
  final int count;

  /// The category of the quiz
  final Category category;

  /// The difficulty of the quiz
  final QuestionDifficulty difficulty;

  /// The type of the questions
  final QuestionType type;

  /// A list of questions from the API
  final List<Question> questions;

  /// Date and time at the start of the quiz. Null means the quiz is yet to begin
  final DateTime? start;

  /// Date and time at the end of the quiz. Null means the quiz is yet to be finished
  final DateTime? end;

  const QuizState(this.progress, this.count, this.category, this.difficulty, this.type,
      this.questions, this.start, this.end);

  /// Creates a copy of the current object with any given new values applied over it.
  /// This helps maintain immutability in the state.
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
    /// If the given new values are identical or if there are no new values, returns this object itself
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
