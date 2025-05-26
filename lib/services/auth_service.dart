<<<<<<< HEAD
import 'package:dio/dio.dart';
import 'package:arthub/core/api_cliente.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Método para login
  Future<String> login(String email, String senha) async {
    try {
      final response = await _apiClient.post('/api/v2/auth/login', {
        'email': email,
        'senha': senha,
      });
      return response.data.toString();
    } on DioException catch (e) {
      if (e.response != null) {
        print('Erro no login - Status: ${e.response?.statusCode}');
        print('Resposta do servidor: ${e.response?.data}');
      } else {
        print('Erro no login - Sem resposta do servidor');
        print('Mensagem: ${e.message}');
      }
      throw Exception('Falha ao fazer login');
    } catch (e) {
      print('Erro inesperado: $e');
      throw Exception('Erro desconhecido ao fazer login');
    }
  }

  // Método para registrar usuário
  Future<Response> register(String nome, String email, String senha) async {
    try {
      final response = await _apiClient.post('/api/v2/auth/registrar', {
        'nome': nome,
        'email': email,
        'senha': senha,
      });
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Erro no cadastro - Status: ${e.response?.statusCode}');
        print('Resposta do servidor: ${e.response?.data}');
      } else {
        print('Erro no cadastro - Sem resposta do servidor');
        print('Mensagem: ${e.message}');
      }
      throw Exception('Falha ao cadastrar usuário');
    } catch (e) {
      print('Erro inesperado: $e');
      throw Exception('Erro desconhecido ao cadastrar usuário');
    }
  }
}
=======
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static final String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
>>>>>>> 77fc1062777cca9f4439e74edf033796a780483d
