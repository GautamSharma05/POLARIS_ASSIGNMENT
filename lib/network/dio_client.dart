import 'package:dio/dio.dart';

class DioClient {
  static getDio() {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json;charset=UTF-8";
    dio.options.contentType = Headers.jsonContentType;
    dio.options.connectTimeout = const Duration(milliseconds: 10000); //10s
    dio.options.receiveTimeout =  const Duration(milliseconds: 10000); //10s
    return dio;
  }

  static getDioFormData() {
    final dio = Dio();
    dio.options.contentType = Headers.acceptHeader;
    return dio;
  }
}
