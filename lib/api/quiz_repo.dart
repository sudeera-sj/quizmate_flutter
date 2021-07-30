import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizmate_flutter/api/api_controller.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_state.dart';
import 'package:quizmate_flutter/models/data/question.dart';
import 'package:quizmate_flutter/models/data/trivia.dart';
import 'package:quizmate_flutter/models/util/question_difficulty.dart';
import 'package:quizmate_flutter/models/util/question_type.dart';

/// The repository for quiz-related API calls
class QuizRepo {
  /// HtmlUnescape is used to decode special HTML characters in strings returned from the API
  final HtmlUnescape _unescape = HtmlUnescape();
  final Dio _requestManager;

  QuizRepo(APIController controller) : this._requestManager = controller.requestManager;

  /// Creates a quiz based on the attributes of the current quiz state
  Future<List<Question>> fetchQuiz(QuizState state) async {
    var url = 'api.php?amount=${state.count}';

    if (state.category.id > 0) {
      url += '&category=${state.category.id}';
    }

    if (state.difficulty != QuestionDifficulty.any) {
      url += '&difficulty=${state.difficulty.toString()}';
    }

    if (state.type != QuestionType.any) {
      url += '&type=${state.type.toString()}';
    }

    final response = await _requestManager.get<String>(url);

    if (response.statusCode != 200) {
      throw Exception('Could not fetch categories due to a server error');
    }

    return _setupQuestions(Trivia.fromJson(jsonDecode(response.data ?? '')));
  }

  /// Converts a trivia returned by the API into a quiz.
  List<Question> _setupQuestions(Trivia trivia) {
    return trivia.results.map((triviaEntry) {
      /// Adding the correct answer into the list of incorrect answers and shuffling them,
      /// Resulting in one unified set of possible answers
      triviaEntry.incorrectAnswers.add(triviaEntry.correctAnswer);
      triviaEntry.incorrectAnswers.shuffle();

      /// Maps the trivia entry from the API into a proper question
      return Question(
        _unescape.convert(triviaEntry.question),
        _unescape.convert(triviaEntry.correctAnswer),
        '',
        triviaEntry.incorrectAnswers.map((answer) => _unescape.convert(answer)).toList(),
      );
    }).toList();
  }
}
