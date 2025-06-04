import 'package:arthub/models/usuario_model.dart';

class PerfilModel {
  final String biografia;
  final String fotoPerfil;
  final String banner;
  final UsuarioModel usuario;

  PerfilModel({
    required this.biografia,
    required this.fotoPerfil,
    required this.banner,
    required this.usuario,
  });

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      biografia: json['biografia'],
      fotoPerfil: json['fotoPerfil'],
      banner: json['banner'],
      usuario: UsuarioModel.fromJson(json['usuario']),
      // publicacoes:
      //     (json['publicacoes'] as List)
      //         .map((publicacao) => PublicacaoModel.fromJson(publicacao))
      //         .toList(),
      // comentarios:
      //     (json['comentarios'] as List)
      //         .map((comentario) => ComentarioModel.fromJson(comentario))
      //         .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biografia': biografia,
      'fotoPerfil': fotoPerfil,
      'banner': banner,
      'usuario': usuario.toJson(),
      // 'publicacoes':
      //     publicacoes.map((publicacao) => publicacao.toJson()).toList(),
      // 'comentarios':
      //     comentarios.map((comentario) => comentario.toJson()).toList(),
    };
  }
}
