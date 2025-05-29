import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/cadastro_model.dart';
import 'package:arthub/models/dtos/login_dto.dart';
import 'package:arthub/services/auth_service.dart';

class UsuarioService {
  static final ApiClient _apiClient = ApiClient();

  static Future<String> login(LoginDTO login) async {
    final response = await _apiClient.post('/auth/login', {
      'email': login.email,
      'senha': login.senha,
    });

    if (response.statusCode == 200) {
      final token = response.data;
      AuthService.saveToken(token);
      return token;
    } else if (response.statusCode == 403) {
      throw Exception('Senha ou e-mail incorretos');
    } else {
      throw Exception('Falha ao fazer o login');
    }
  }

  static Future<void> cadastrarUsuario(CadastroModel cadastro) async {
    final response = await _apiClient.post('/auth/registrar', {
      'nome': cadastro.nome,
      'apelido': cadastro.apelido,
      'email': cadastro.email,
      'senha': cadastro.senha,
      'telefone': cadastro.telefone,
      'dataNascimento': cadastro.dataNascimento,
    });

    print(response.data);
    print(response.statusCode);

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar usuário');
    }
  }
}
