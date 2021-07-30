import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

class CategoryState {
  static const CategoryState initialState = CategoryState(TaskProgress.idle, []);

  final TaskProgress progress;
  final List<Category> categories;

  const CategoryState(this.progress, this.categories);

  CategoryState copyWith({
    TaskProgress? progress,
    List<Category>? categories,
  }) {
    if ((progress == null || identical(progress, this.progress)) &&
        (categories == null || identical(categories, this.categories))) {
      return this;
    }

    return new CategoryState(
      progress ?? this.progress,
      categories ?? this.categories,
    );
  }
}
