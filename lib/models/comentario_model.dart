import 'package:arthub/models/perfil_model.dart';

class ComentarioModel {
  final int id;
  final int curtidas;
  final DateTime dataPublicacao;
  final String conteudo;
  final PerfilModel perfil;

  ComentarioModel({
    required this.id,
    required this.curtidas,
    required this.dataPublicacao,
    required this.conteudo,
    required this.perfil,
  });

  factory ComentarioModel.fromJson(Map<String, dynamic> json) {
    return ComentarioModel(
      id: json['id'],
      curtidas: json['curtidas'],
      dataPublicacao: DateTime.parse(json['dataPublicacao']),
      conteudo: json['conteudo'],
      perfil: PerfilModel.fromJson(json['perfil']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curtidas': curtidas,
      'dataPublicacao': dataPublicacao,
      'conteudo': conteudo,
      'perfil': perfil.toJson(),
    };
  }
}
