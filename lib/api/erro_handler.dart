import 'package:dio/dio.dart';

class ApiErrorHandler{

  static String handler(DioException error){
    switch(error.type){
      case DioExceptionType.badResponse:
        return 'BadResponse: Algo de errado aconteceu na resposta \n ${error.response}';
      case DioExceptionType.connectionError:
        return 'ConectionError: Houve um erro na conexão';
      case DioExceptionType.connectionTimeout:
        return 'ConnectionTimeout: A conexão expirou';
      case DioExceptionType.badCertificate:
        return 'BacCertificate: Um erro aconteceu na autenticação';
      case DioExceptionType.sendTimeout:
        return 'SendTimeout';
      case DioExceptionType.receiveTimeout:
        return 'ReceiveTimeout';
      case DioExceptionType.cancel:
        return 'Cancel';
      case DioExceptionType.unknown:
        return 'Unknown';
    }
  }

  static String _handlerReponseError(Response? response){
    switch(response?.statusCode){
      case 404:
        return 'Not Found';
      case 400:
        return 'Bad Request';
      case 405:
        return 'Method Not Allowed';
      case 409:
        return 'Conflict';
      case 500:
        return 'Internal Server Error';
      case 403:
        return 'Forbidden';
      default:
        return "Um erro desconhecido aconteceu";
    }
  }
}