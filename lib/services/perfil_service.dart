import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/perfil_model.dart';

class PerfilService {
  static final ApiClient _apiClient = ApiClient();

  static Future<PerfilModel> getUsuario(String id) async {
    final response = await _apiClient.get('/usuarios/$id');

    if (response.statusCode == 200) {
      return PerfilModel.fromJson(response.data);
    } else {
      throw Exception('Falha ao obter o Perfil do usuário!');
    }
  }
}
