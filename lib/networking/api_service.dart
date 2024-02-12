import 'package:dio/dio.dart' as dio;

import '../core/constants/api_endpoint.dart';
import '../core/constants/error.dart';
import '../core/constants/typedef.dart';


abstract class ApiService {
  Future<dio.Response?> get(String url, parameters? params);
  Future<dioRes?> post(String url, parameters params, var data);
}

class ApiServiceDio implements ApiService {
  late dio.Dio _dio;
  ApiServiceDio() {
    dio.BaseOptions options = dio.BaseOptions(
        baseUrl: Api.mainUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 8), // 60 seconds
        receiveTimeout: const Duration(seconds: 8),
        headers: {
          'Content-Type': 'text/plain',
        },
      );
    _dio = dio.Dio(options);
  }
  @override
  Future<dioRes?> get(String url, parameters? params) async {
    try {
      dioRes response = await _dio.get(url, queryParameters: params);
      return response;
    } on dio.DioException catch (e) {
      print("error in get service $e");
      DioExceptions().getExceptionType(e);
      return null;
    }
  }

  @override
  Future<dioRes?> post(String url, parameters params, var data) async {
    try {
      dioRes? response =
          await _dio.post(url, queryParameters: params, data: data);
      return response;
    } on dio.DioException catch (e) {
      print("error in post service $e");
      DioExceptions().getExceptionType(e);
      return null;
    }
  }
}
