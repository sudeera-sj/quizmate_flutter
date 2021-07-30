import 'package:bloc/bloc.dart';
import 'package:quizmate_flutter/api/category_repo.dart';
import 'package:quizmate_flutter/bloc/category/category_state.dart';
import 'package:quizmate_flutter/models/util/connectivity_listener.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';

/// The BLoC component for category-related operations
class CategoryBloc extends Cubit<CategoryState> implements ConnectivityListener {
  final CategoryRepo _repo;

  CategoryBloc(this._repo) : super(CategoryState.initialState);

  @override
  Future<void> onConnectionChange(bool isConnected) async {
    if (isConnected) {
      await fetchCategories();
    }
  }

  /// Fetches all available quiz categories and updates the state
  Future<void> fetchCategories() async {
    if (state.progress == TaskProgress.success || state.progress == TaskProgress.pending) {
      return;
    }

    emit(state.copyWith(progress: TaskProgress.pending));

    try {
      final categories = await _repo.fetchCategories();
      emit(CategoryState(TaskProgress.success, categories));
    } catch (e) {
      emit(CategoryState(TaskProgress.error, []));
      addError(e, StackTrace.current);
    }
  }
}
