import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/publicacao_model.dart';

class PublicacaoService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<PublicacaoModel>> getAllPublicacao() async {
    final response = await _apiClient.get('/publicacoes');
    List<PublicacaoModel> publicacoes =
        (response.data as List)
            .map((publicacao) => PublicacaoModel.fromJson(publicacao))
            .toList();

    if (response.statusCode == 200) {
      return publicacoes;
    }

    throw Exception('Algo deu errado ao buscar publicações');
  }

  static Future<List<PublicacaoModel>> getPublicacaoByUsuario() async {
    final response = await _apiClient.get('/usuario/{idUsuario}');
    List<PublicacaoModel> pubicacoesDoUsuario =
        (response.data as List)
            .map((post) => PublicacaoModel.fromJson(post))
            .toList();

    if (response.statusCode == 200) {
      return pubicacoesDoUsuario;
    }

    throw Exception('Algo deu errado ao buscar as publicações do usuário');
  }
}
