import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/publicacao_model.dart';

class PublicacaoService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<PublicacaoModel>> getAllPublicacao() async {
    print('chegou até aqui');
    final response = await _apiClient.get('/publicacoes');
    print(response.statusCode);
    final List<PublicacaoModel> publicacoes =
        (response.data as List)
            .map((publicacao) => PublicacaoModel.fromJson(publicacao))
            .toList();
    print(publicacoes[1]);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return publicacoes;
    }

    throw Exception('Algo deu errado ao buscar publicações');
  }
}
