import 'package:arthub/models/comentario_model.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/models/usuario_model.dart';

class PerfilModel {
  final int id;
  final String biografia;
  final String fotoPerfil;
  final String banner;
  final UsuarioModel usuario;
  final List<PublicacaoModel> publicacoes;
  final List<ComentarioModel> comentarios;

  PerfilModel({
    required this.id,
    required this.biografia,
    required this.fotoPerfil,
    required this.banner,
    required this.usuario,
    required this.publicacoes,
    required this.comentarios,
  });

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      id: json['id'],
      biografia: json['biografia'],
      fotoPerfil: json['fotoPerfil'],
      banner: json['banner'],
      usuario: UsuarioModel.fromJson(json['usuario']),
      publicacoes:
          (json['publicacoes'] as List)
              .map((publicacao) => PublicacaoModel.fromJson(publicacao))
              .toList(),
      comentarios:
          (json['comentarios'] as List)
              .map((comentario) => ComentarioModel.fromJson(comentario))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biografia': biografia,
      'fotoPerfil': fotoPerfil,
      'banner': banner,
      'usuario': usuario.toJson(),
      'publicacoes':
          publicacoes.map((publicacao) => publicacao.toJson()).toList(),
      'comentarios':
          comentarios.map((comentario) => comentario.toJson()).toList(),
    };
  }
}
