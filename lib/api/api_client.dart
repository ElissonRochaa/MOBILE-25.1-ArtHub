import 'package:arthub/services/auth_service.dart';
import 'package:dio/dio.dart';

class ApiClient {

  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/api/v2'));

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AuthService.getToken();
          if (token != null){
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if(error.response?.statusCode == 401){
            await AuthService.removeToken();
          }
          return handler.next(error);
        }
      )
    );
  }

  Future<Response> get(String endPoint) async {
    return await _dio.get(endPoint);
  }

  Future<Response> post(String endPoint, Map<String, dynamic> json) async {
    return await _dio.post(endPoint, data: json);
  }
  
  Future<Response> delete(String endPoit, Map<String, dynamic> json) async {
    return await _dio.delete(endPoit, data: json);
  }

  Future<Response> put(String endPoint, Map<String, dynamic> json) async {
    return await _dio.put(endPoint, data: json);
  }
}