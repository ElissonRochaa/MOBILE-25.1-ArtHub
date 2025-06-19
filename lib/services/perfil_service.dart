import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/dtos/perfil_editado_DTO.dart';
import 'package:arthub/models/perfil_model.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

class PerfilService {
  static final ApiClient _apiClient = ApiClient();

  static Future<PerfilModel> getPerfilByUsuarioId(int usuarioId) async {
    final response = await _apiClient.get('/perfis/$usuarioId');

    if (response.statusCode != 200) {
      throw Exception('Erro no getPerfilByUsuarioId');
    }

    return PerfilModel.fromJson(response.data);
  }

  static Future<ImageProvider?> getImagePerfil(int perfilId) async {
    try {
      final response = await _apiClient.get(
        '/perfis/fotoPerfil/$perfilId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 &&
          (response.data == null ||
              (response.data is List && (response.data as List).isEmpty))) {
        return null;
      }

      if (response.statusCode == 200 && response.data != null) {
        return MemoryImage(Uint8List.fromList(response.data.cast<int>()));
      }
      return null;
    } catch (e) {
      throw Exception('Erro no getImagePerfil');
    }
  }

  static Future<ImageProvider?> getImageBanner(int perfilId) async {
    try {
      final response = await _apiClient.get(
        '/perfis/banner/$perfilId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 &&
          (response.data == null ||
              (response.data is List && (response.data as List).isEmpty))) {
        return null;
      }

      if (response.statusCode == 200 && response.data != null) {
        return MemoryImage(Uint8List.fromList(response.data.cast<int>()));
      }
      return null;
    } catch (e) {
      throw Exception('Erro no getImageBanner');
    }
  }

  static Future<List<int>> getSeguidoresAndSeguindo(int perfilId) async {
    try {
      final responseSeguidores = await _apiClient.get(
        '/perfis/seguidores/$perfilId',
      );
      final responseSeguindo = await _apiClient.get(
        '/perfis/seguindo/$perfilId',
      );

      if ((responseSeguindo.statusCode == 200 &&
              responseSeguindo.data != null) &&
          (responseSeguidores.statusCode == 200 &&
              responseSeguidores.data != null)) {
        final seguidoresData =
            (responseSeguidores.data as List)
                .map((perfil) => PerfilModel.fromJson(perfil))
                .toList();

        final seguindoData =
            (responseSeguindo.data as List)
                .map((perfil) => PerfilModel.fromJson(perfil))
                .toList();

        return [seguidoresData.length, seguindoData.length];
      }

      return [0, 0];
    } catch (e) {
      throw Exception('Erro no getSeguidoresAndSeguindo');
    }
  }

  static Future<List<PublicacaoModel>> getPublicacoesByUsuarioId(
    int usuarioId,
  ) async {
    try {
      final response = await _apiClient.get('/publicacoes/usuario/$usuarioId');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data;
        return data.map((json) => PublicacaoModel.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      throw Exception('Erro no getPublicacoesByUsuarioId');
    }
  }

  static Future<List<PerfilModel>> pesquisarPerfis(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final response = await _apiClient.get('/perfis/pesquisar?q=$query');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data;
        return data.map((json) => PerfilModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Erro ao pesquisar perfis: $e');
      throw Exception('Erro ao pesquisar perfis');
    }
  }

  static Future<void> putPerfil(PerfilEditadoDTO dto, int? donoId) async {
    try{
      await _apiClient.put(
          '/perfis/$donoId',
          data: dto.toJson());
    }
    catch (e) {
      throw Exception('Erro no putPerfil');
    }
  }

  static ({String extension, String mimeType}) _definirExtensao({File? imageFile, Uint8List? imageWeb}){
    try {
      String extension = 'jpg';

      if (imageFile != null){
        extension = path.extension(imageFile.path).toLowerCase().replaceAll('.', '');
      } else if (imageWeb != null){
        if (imageWeb.length >= 2){
          if (imageWeb[0] == 0xFF && imageWeb[1] == 0xD8) {
            extension = 'jpg';
          } else if (imageWeb[0] == 0x89 && imageWeb[1] == 0x50) {
            extension = 'png';
          }
        }
      }

      final mimeType = switch(extension) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        _ => throw Exception('Formato de imagem não suportado $extension')
      };

      return (extension: extension, mimeType: mimeType);
    }
    catch (e){
      throw Exception('Erro no _definirExtensao');
    }
  }

  static Future<void> uploadImagem(int perfilId, File? imageFile,
      Uint8List? imageWeb, bool fotoOuBanner) async {
    try {
      final tipo = _definirExtensao(
          imageFile: imageFile,
          imageWeb: imageWeb
      );

      final formData = FormData.fromMap({
        'file': imageFile != null
            ? await MultipartFile.fromFile(
            imageFile.path,
            filename: 'perfil_$perfilId.${tipo.extension}',
            contentType: DioMediaType.parse(tipo.mimeType))
            : MultipartFile.fromBytes(
            imageWeb!.toList(),
            filename: 'perfil_$perfilId.${tipo.extension}',
            contentType: DioMediaType.parse(tipo.mimeType))
      });

      final response = await _apiClient.putImage(
        fotoOuBanner ? '/perfis/uploadPerfil/$perfilId' : '/perfis/uploadBanner/$perfilId',
        formData,
        Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode != 200){
        throw Exception('Falha no upload: ${response.statusCode}');
      }
    }
    catch (e) {
      throw Exception('Erro no uploadImagem');
    }
  }
}
