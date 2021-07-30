/// Represents a single question in a quiz
class Question {
  final String text;
  final String correctAnswer;
  final String givenAnswer;
  final List<String> allAnswers;

  const Question(this.text, this.correctAnswer, this.givenAnswer, this.allAnswers);

  Question copyWith({String? givenAnswer}) {
    if (givenAnswer == null || identical(givenAnswer, this.givenAnswer)) {
      return this;
    }

    return new Question(this.text, this.correctAnswer, givenAnswer, this.allAnswers);
  }
}
