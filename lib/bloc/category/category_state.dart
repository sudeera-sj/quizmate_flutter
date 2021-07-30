import 'package:quizmate_flutter/models/data/category.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

/// The state for category related operations
class CategoryState {
  static const CategoryState initialState = CategoryState(TaskProgress.idle, []);

  /// The progress of fetching categories from the API
  final TaskProgress progress;

  /// A list of available quiz categories
  final List<Category> categories;

  const CategoryState(this.progress, this.categories);

  /// Creates a copy of the current object with any given new values applied over it.
  /// This helps maintain immutability in the state.
  CategoryState copyWith({
    TaskProgress? progress,
    List<Category>? categories,
  }) {
    /// If the given new values are identical or if there are no new values, returns this object itself
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
