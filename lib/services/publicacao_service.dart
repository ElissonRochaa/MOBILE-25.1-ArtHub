import 'dart:convert';
import 'dart:typed_data';
import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:dio/dio.dart';

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

  static Future<Uint8List> getBytes(String idPublicacao) async {
    try {
      final response = await _apiClient.getBytes(
        '/publicacoes/midia/$idPublicacao',
      );

      if (response.statusCode == 200 && response.data != null) {
        return Uint8List.fromList(response.data!);
      } else {
        throw Exception(
          'Falha ao carregar bytes da imagem. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception(
          'Acesso negado à mídia (403). Verifique as permissões e autenticação.',
        );
      }
      throw Exception(
        'Erro de rede ao buscar imagem: ${e.response?.statusCode} - ${e.message}',
      );
    } catch (e) {
      throw Exception('Erro desconhecido ao buscar imagem: $e');
    }
  }
}
