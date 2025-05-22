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
}
