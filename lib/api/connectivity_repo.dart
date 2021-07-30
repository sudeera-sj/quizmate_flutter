import 'package:dio/dio.dart';
import 'package:quizmate_flutter/api/api_controller.dart';

class ConnectivityRepo {
  final Dio _requestManager;

  ConnectivityRepo(APIController controller) : this._requestManager = controller.requestManager;

  Future<bool> checkConnectivity() async {
    final response = await _requestManager.get<String>('');
    return response.statusCode == 200;
  }
}
