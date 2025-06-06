import 'package:arthub/models/usuario_model.dart';

class PerfilModel {
  final int id;
  final String? biografia;
  final String? fotoPerfil;
  final String? banner;
  final UsuarioModel usuario;

  PerfilModel({
    required this.id,
    required this.biografia,
    required this.fotoPerfil,
    required this.banner,
    required this.usuario,
  });

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      id: json['id'],
      biografia: json['biografia'],
      fotoPerfil: json['fotoPerfil'],
      banner: json['banner'],
      usuario: UsuarioModel.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biografia': biografia,
      'fotoPerfil': fotoPerfil,
      'banner': banner,
      'usuario': usuario.toJson(),
    };
  }
}
