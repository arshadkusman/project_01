import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  DioService() {
    _dio.options = BaseOptions(
      baseUrl: 'https://669f6598b132e2c136fdb292.mockapi.io',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 5),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}
