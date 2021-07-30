import 'package:dio/dio.dart';

/// Contains the customized Dio instance for making API calls
class APIController {
  final Dio requestManager = Dio(
    BaseOptions(
      baseUrl: 'https://opentdb.com/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  static final APIController _singleton = APIController._internal();

  factory APIController() {
    return _singleton;
  }

  APIController._internal();
}
