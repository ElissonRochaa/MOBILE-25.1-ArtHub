import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/dots/login_dto.dart';
import 'package:arthub/services/auth_service.dart';

class UsuarioService{
  static final ApiClient _apiClient = ApiClient();

  static Future<String> login(LoginDTO login) async {
    final response = await _apiClient.post('/auth/login', {
      'email': login.email,
      'senha' : login.senha,
    });

    if (response.statusCode == 200){
      final token = response.data;
      AuthService.saveToken(token);
      return token;
    } else if (response.statusCode == 403){
       throw Exception('Senha ou e-mail incorretos');
    }
    else {
      throw Exception('Falha ao fazer o login');
    }
  }
}