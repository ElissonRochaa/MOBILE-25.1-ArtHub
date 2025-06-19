import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService {
  static final ApiClient _apiClient = ApiClient();
  static const String emailKey = 'email_key';

  static Future<int?> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(emailKey);
  }

  static Future<UsuarioModel> getUsuarioByEmail(String email) async {
    final response = await _apiClient.get('/usuarios/email/$email');
    final UsuarioModel usuario = UsuarioModel.fromJson(response.data);

    if (response.statusCode == 200){
      return usuario;
    }
    throw Exception('Algo deu errado ao buscar o usuário por email');
  }

  static Future<UsuarioModel> getUsuarioById(int id) async {
    final response = await _apiClient.get('/usuarios/$id');
    final UsuarioModel usuario = UsuarioModel.fromJson(response.data);

    if (response.statusCode == 200){
      return usuario;
    }
    throw Exception('Algo deu errado ao buscar o usuário por id');
  }

  static Future<bool> deleteUsuario(int id) async {
    try {
      final response = await _apiClient.delete('/usuarios/remover/$id');

      if (response.statusCode == 204){
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Algo deu errado ao deletar o usuário $e');
    }
  }
}
