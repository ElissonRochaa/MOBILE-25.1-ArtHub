import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/comentario_model.dart';

class ComentarioService {
  static final ApiClient _api = ApiClient();

  static Future<List<ComentarioModel>> getComentarios(int idPublicacao) async {
    final response = await _api.get('/comentarios/publicacao/$idPublicacao');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ComentarioModel.fromJson(json)).toList();
  }

  static Future<void> postarComentario(
      int idPublicacao, int idDono, String conteudo) async {
    final body = {'conteudo': conteudo};
    await _api.post('/comentarios/$idDono/$idPublicacao', body);
  }
}
