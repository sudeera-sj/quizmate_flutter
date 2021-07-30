import 'package:quizmate_flutter/models/data/category.dart';

class TriviaCategories {
  final List<Category> categories;

  TriviaCategories(this.categories);

  TriviaCategories.fromJson(dynamic json) : this.categories = [] {
    if (json["trivia_categories"] != null) {
      json["trivia_categories"].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }
}
