import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/usuario_model.dart';

class UsuarioService {
  static final ApiClient _apiClient = ApiClient();

  // Mesmo nome no Backend
  // Future<UsuarioModel> buscarUsuarioPorId(String id) async {
  //   final response = await _apiClient.get('/usuarios/$id');

  //   if (response.statusCode == 200) {
  //     return UsuarioModel.fromJson(response.data);
  //   } else {
  //     throw Exception('Falha ao obter o usuário!');
  //   }
  // }

  Future<UsuarioModel> buscarUsuarioPorEmail(String email) async {
    final response = await _apiClient.get('/email/$email');

    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(response.data);
      // print("Retornou!")
    } else {
      throw Exception("Falha em obter o usuário por email!");
    }
  }
}
