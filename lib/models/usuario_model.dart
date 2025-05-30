import 'package:arthub/enums/usuario_enum.dart';
import 'package:arthub/models/perfil_model.dart';

class UsuarioModel {
  final int id;
  final String nome;
  final String apelido;
  final String email;
  final String telefone;
  final UsuarioEnum tipoUsuario;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.apelido,
    required this.email,
    required this.telefone,
    required this.tipoUsuario,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      apelido: json['apelido'],
      email: json['email'],
      telefone: json['telefone'],
      tipoUsuario: json['tipoUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'apelido': apelido,
      'email': email,
      'telefone': telefone,
      'tipoUsuario': tipoUsuario,
    };
  }
}
