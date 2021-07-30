import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/api/quiz_repo.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/util/connectivity_listener.dart';
import 'package:quizmate_flutter/models/util/question_difficulty.dart';
import 'package:quizmate_flutter/models/util/question_type.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

/// The BLoC component for quiz-related operations
class QuizBloc extends Cubit<QuizState> implements ConnectivityListener {
  final QuizRepo _repo;

  QuizBloc(this._repo) : super(QuizState.initialState);

  @override
  Future<void> onConnectionChange(bool isConnected) async {
    if (isConnected && state.progress == TaskProgress.error) {
      await _createQuiz();
    }
  }

  void setCount(int count) {
    if (count < 10 || count > 30) {
      return;
    }

    emit(state.copyWith(count: count));
  }

  void setCategory(Category category) => emit(state.copyWith(category: category));

  void setDifficulty(QuestionDifficulty difficulty) => emit(state.copyWith(difficulty: difficulty));

  void setType(QuestionType type) => emit(state.copyWith(type: type));

  Future<void> createQuiz() async {
    if (state.progress == TaskProgress.idle || state.progress == TaskProgress.error) {
      await _createQuiz();
    }
  }

  /// Fetches data from the API and creates a quiz using the current state
  Future<void> _createQuiz() async {
    emit(state.copyWith(progress: TaskProgress.pending));

    try {
      final questions = await _repo.fetchQuiz(state);

      emit(
        state.copyWith(
          progress: TaskProgress.success,
          questions: questions,
          start: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(progress: TaskProgress.error, questions: []));
      addError(e, StackTrace.current);
    }
  }

  void answerQuestion(int question, int answer) {
    final currentQuestion = state.questions[question];

    state.questions[question] = currentQuestion.copyWith(
      givenAnswer: currentQuestion.allAnswers[answer],
    );

    emit(state.copyWith(questions: state.questions.toList(growable: false)));
  }

  void submitQuiz() => emit(state.copyWith(end: DateTime.now()));

  void endQuiz() => emit(QuizState.initialState);
}
