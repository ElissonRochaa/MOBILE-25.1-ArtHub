import 'dart:convert';
import 'dart:typed_data';
import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/token_service.dart';
import 'package:arthub/services/usuario_service.dart';
import 'package:dio/dio.dart';

class PublicacaoService {
  static ApiClient _apiClient = ApiClient();

  // Future<int> getIdDono() async {
  //   String email = await TokenService.decodeToken(); //Extrai o email do token
  //   final usuario = await UsuarioService.getUsuarioByEmail(
  //     email,
  //   ); //Busca o usuário pelo email

  //   return usuario.id; //Pega o ID!
  // }

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

  static Future<PublicacaoModel> putPublicacao(
    PublicacaoModel publicacao,
  ) async {
    String email = await TokenService.decodeToken(); //Extrai Email
    final usuario = await UsuarioService.getUsuarioByEmail(
      email,
    ); //Pega o usuário pelo email
    int idDono = usuario.id; //Pega o ID do usuário
    // Acreditem, a gente vai usar isso sempre!
    // final data = publicacao.toEditJson();
    // print("Teste de JSON: $data");
    final response = await _apiClient.put(
      '/publicacoes/$idDono',
      data: publicacao.toEditJson(),
    );

    if (response.statusCode == 200) {
      return PublicacaoModel.fromJson(response.data);
    }

    throw Exception('Algo deu errado ao atualizar a publicação');
  }

  static Future<PublicacaoModel> getById(int idPublicacao) async {
    //Buscar publicação por ID
    final response = await _apiClient.get('/publicacoes/$idPublicacao');
    if (response.statusCode == 200) {
      return PublicacaoModel.fromJson(response.data);
    }
    throw Exception('Erro ao buscar publicação por ID');
  }
}
