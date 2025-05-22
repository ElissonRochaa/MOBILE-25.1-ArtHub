class ComentarioModel {
  final int id;
  final int curtidas;
  final DateTime dataPublicacao;
  final String conteudo;

  ComentarioModel({
    required this.id,
    required this.curtidas,
    required this.dataPublicacao,
    required this.conteudo,
  });

  factory ComentarioModel.fromJson(Map<String, dynamic> json){
    return ComentarioModel(
      id: json['id'], 
      curtidas: json['curtidas'], 
      dataPublicacao: json['dataPublicacao'], 
      conteudo: json['conteudo'],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curtidas': curtidas,
      'dataPublicacao': dataPublicacao,
      'conteudo': conteudo,
    };
  }
}
