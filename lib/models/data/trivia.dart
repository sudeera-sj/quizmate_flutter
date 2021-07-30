/// Represents a successful API response for a quiz request
class Trivia {
  final int responseCode;
  final List<_TriviaEntry> results;

  const Trivia(this.responseCode, this.results);

  Trivia.fromJson(dynamic json)
      : this.responseCode = json["response_code"],
        this.results = [] {
    json["results"].forEach((v) {
      results.add(_TriviaEntry.fromJson(v));
    });
  }
}

class _TriviaEntry {
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const _TriviaEntry(this.category, this.question, this.correctAnswer, this.incorrectAnswers);

  _TriviaEntry.fromJson(dynamic json)
      : this.category = json["category"],
        this.question = json["question"],
        this.correctAnswer = json["correct_answer"],
        this.incorrectAnswers =
        json["incorrect_answers"] != null ? json["incorrect_answers"].cast<String>() : [];
}
