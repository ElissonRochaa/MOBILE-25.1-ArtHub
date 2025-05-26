import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:arthub/models/usuario_model.dart';

class UsuarioController {
  final String baseUrl = 'http://192.168.1.102:8080/usuarios';

  Future<UsuarioModel> buscarUsuarioPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  Future<UsuarioModel> buscarUsuarioPorApelido(String apelido) async {
    final response = await http.get(
      Uri.parse('$baseUrl/buscarApelido/$apelido'),
    );
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  Future<UsuarioModel> buscarUsuarioPorEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/email/$email'));
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  Future<UsuarioModel> buscarUsuarioLogado(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dados'),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  Future<UsuarioModel> atualizarUsuario(
    Map<String, dynamic> usuarioEditado,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/atualizar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuarioEditado),
    );
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar usuário');
    }
  }

  Future<UsuarioModel> promoverUsuarioParaAdmin(int adminId, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/promover/admin/$adminId/$id?adminId=$adminId'),
    );
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao promover usuário');
    }
  }

  Future<void> removerUsuario(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/remover/$id'));
    if (response.statusCode != 204) {
      throw Exception('Falha ao remover usuário');
    }
  }
}
