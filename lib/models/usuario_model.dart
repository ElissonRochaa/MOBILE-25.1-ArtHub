import 'package:arthub/enums/usuario_enum.dart';
import 'package:arthub/models/perfil_model.dart';

class UsuarioModel {
  final int id;
  final String nome;
  final String apelido;
  final String email;
  final DateTime dataNascimento;
  final String senha;
  final String telefone;
  final PerfilModel perfil;
  final UsuarioEnum tipoUsuario;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.apelido,
    required this.email,
    required this.dataNascimento,
    required this.senha,
    required this.telefone,
    required this.perfil,
    required this.tipoUsuario,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      apelido: json['apelido'],
      email: json['email'],
      dataNascimento: json['dataNascimento'],
      senha: json['senha'],
      telefone: json['telefone'],
      perfil: PerfilModel.fromJson(json['perfil']),
      tipoUsuario: json['tipoUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'apelido': apelido,
      'email': email,
      'dataNascimento': dataNascimento,
      'senha': senha,
      'telefone': telefone,
      'perfil': perfil.toJson(),
      'tipoUsuario': tipoUsuario,
    };
  }
}
