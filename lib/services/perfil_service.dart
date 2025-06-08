import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/perfil_model.dart';
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

      if (response.statusCode == 200 && response.data != null){
        return MemoryImage(response.data);
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

      if (response.statusCode == 200 && response.data != null){
        return MemoryImage(response.data);
      }

      return null;
    }
    catch (e) {
      throw Exception('Erro no getImagePerfil');
    }
  }
}