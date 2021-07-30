import 'package:dio/dio.dart';
import 'package:quizmate_flutter/api/api_controller.dart';

/// Repository for checking internet connection availability
class ConnectivityRepo {
  final Dio _requestManager;

  ConnectivityRepo(APIController controller) : this._requestManager = controller.requestManager;

  /// Checks if the API is reachable. If yes, returns true. False otherwise.
  Future<bool> checkConnectivity() async {
    final response = await _requestManager.get<String>('');
    return response.statusCode == 200;
  }
}
