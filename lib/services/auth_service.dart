import 'package:arthub/models/cadastro_model.dart';
import 'package:arthub/services/token_service.dart';

import '../api/api_client.dart';
import '../models/dtos/login_dto.dart';

class AuthService {
  static final ApiClient _apiClient = ApiClient();

  static Future<String> login(LoginDTO login) async {
    final response = await _apiClient.post('/auth/login', {
      'email': login.email,
      'senha': login.senha,
    });

    if (response.statusCode == 200) {
      final token = response.data;
      TokenService.saveToken(token);
      return token;
    } else {
      throw Exception('Falha ao fazer o login');
    }
  }

  // Aqui o método do Cadastro
  static Future<void> cadastrarUsuario(CadastroModel cadastro) async {
    final response = await _apiClient.post('/auth/registrar', {
      'nome': cadastro.nome,
      'apelido': cadastro.apelido,
      'email': cadastro.email,
      'senha': cadastro.senha,
      'telefone': cadastro.telefone,
      'dataNascimento': cadastro.dataNascimento,
    });

    //Aqui era só debug
    // print(response.data);
    // print(response.statusCode);

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar usuário');
    }
  }
}
