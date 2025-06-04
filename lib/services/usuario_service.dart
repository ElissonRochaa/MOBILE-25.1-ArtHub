import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/usuario_model.dart';

class UsuarioService {
  static final ApiClient _apiClient = ApiClient();
  static int usuarioLogadoId = 0;

  static Future<UsuarioModel> getUsuarioByEmail(String email) async {
    final response = await _apiClient.get('/usuarios/email/$email');
    final UsuarioModel usuario = UsuarioModel.fromJson(response.data);
    usuarioLogadoId = usuario.id;

    if (response.statusCode == 200){
      return usuario;
    }
    throw Exception('Algo deu errado ao buscar o usuário por email');
  }
}
