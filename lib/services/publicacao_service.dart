import 'dart:convert';

import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/publicacao_model.dart';

class PublicacaoService {
  static ApiClient _apiClient = ApiClient();

  static Future<List<PublicacaoModel>> getAllPublicacao() async {
    final response = await _apiClient.get('/publicacoes');
    List<PublicacaoModel> publicacoes = (response.data as List).map((publicacao) => PublicacaoModel.fromJson(publicacao)).toList();
    if(response.statusCode == 200){
      return publicacoes;
    }

    throw Exception('Algo deu errado ao buscar publicações');
  }
}