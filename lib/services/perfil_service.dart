import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/perfil_model.dart';

class PerfilService {
  static final ApiClient _apiClient = ApiClient();

  static Future<PerfilModel> getPerfilByUsuarioId(int usuarioId) async {
    final response = await _apiClient.get('/perfis/$usuarioId');
    final perfil = await PerfilModel.fromJson(response.data);

    if (response.statusCode == 200){
      return perfil;
    }
    throw Exception('Erro no getPerfilByUsuario');
  }
}