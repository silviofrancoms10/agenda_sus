import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'http://192.168.100.76:8080/api',
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST: ${options.method} ${options.uri}');
        print('DATA: ${options.data}');
        print('HEADERS: ${options.headers}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE: ${response.statusCode}');
        print('DATA: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('ERROR: ${error.type}');
        print('STATUS: ${error.response?.statusCode}');
        print('DATA: ${error.response?.data}');
        print('URL: ${error.requestOptions.uri}');
        print('MESSAGE: ${error.message}');
        handler.next(error);
      },
    ));
  }

  void setAuthorizationHeader(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    print("Header de autorização configurado com o token.");
  }

  void clearAuthorizationHeader() {
    dio.options.headers.remove('Authorization');
    print("Header de autorização removido.");
  }
}