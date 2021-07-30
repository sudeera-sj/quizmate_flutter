import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quizmate_flutter/api/api_controller.dart';
import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/data/trivia_categories.dart';

class CategoryRepo {
  final Dio _requestManager;

  CategoryRepo(APIController controller) : this._requestManager = controller.requestManager;

  Future<List<Category>> fetchCategories() async {
    final response = await _requestManager.get<String>('api_category.php');

    if (response.statusCode != 200) {
      throw Exception('Could not fetch categories due to a server error');
    }

    return _setupCategories(TriviaCategories
        .fromJson(jsonDecode(response.data ?? ''))
        .categories);
  }

  List<Category> _setupCategories(List<Category> categories) {
    categories.add(Category.defaultCategory);
    categories.sort((a, b) => a.id - b.id);

    return categories;
  }
}
