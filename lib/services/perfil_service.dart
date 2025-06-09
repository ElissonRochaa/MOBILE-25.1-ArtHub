import 'dart:typed_data';

import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/perfil_model.dart';
import 'package:arthub/models/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PerfilService {
  static final ApiClient _apiClient = ApiClient();

  static Future<PerfilModel> getPerfilByUsuarioId(int usuarioId) async {
    final response = await _apiClient.get('/perfis/$usuarioId');

    if (response.statusCode != 200){
      throw Exception('Erro no getPerfilByUsuario');
    }

    final perfil = await PerfilModel.fromJson(response.data);
    return perfil;
  }

  static Future<ImageProvider?> getImagePerfil(int perfilId) async {
    try{
      final response = await _apiClient.get(
        '/perfis/fotoPerfil/$perfilId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 &&
          (response.data == null ||
              (response.data is List && (response.data as List).isEmpty))) {
        return null;
      }

      if (response.statusCode == 200 && response.data != null){
        return MemoryImage(Uint8List.fromList(response.data.cast<int>()));
      }
      return null;
    }
    catch (e) {
      throw Exception('Erro no getImagePerfil');
    }
  }

  static Future<ImageProvider?> getImageBanner(int perfilId) async {
    try{
      final response = await _apiClient.get(
        '/perfis/banner/$perfilId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 &&
          (response.data == null ||
              (response.data is List && (response.data as List).isEmpty))) {
        return null;
      }

      if (response.statusCode == 200 && response.data != null){
        return MemoryImage(Uint8List.fromList(response.data.cast<int>()));
      }
      return null;
    }
    catch (e) {
      throw Exception('Erro no getImageBanner');
    }
  }

  static Future<List<int>> getSeguidoresAndSeguindo(int perfilId) async {
    try {
      final responseSeguidores = await _apiClient.get('/perfis/seguidores/$perfilId');
      final responseSeguindo = await _apiClient.get('/perfis/seguindo/$perfilId');

      if ((responseSeguindo.statusCode == 200 && responseSeguindo.data != null)
          && (responseSeguidores.statusCode == 200 && responseSeguidores.data != null)){

        final seguidoresData = (responseSeguidores.data as List)
            .map((publicacao) => PerfilModel.fromJson(publicacao))
            .toList();

        final seguindoData = (responseSeguindo.data as List)
            .map((publicacao) => PerfilModel.fromJson(publicacao))
            .toList();

        return [seguidoresData.length, seguindoData.length];
      }

      return [];
    }
    catch (e) {
      throw Exception('Erro no getSeguidoresAndSeguindo');
    }
  }
}