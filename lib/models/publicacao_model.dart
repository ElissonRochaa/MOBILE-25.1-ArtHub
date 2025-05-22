import 'package:arthub/enums/tipo_arquivo_enum.dart';

class PublicacaoModel {
  final int id;
  final TipoArquivoEnum tipoArquivo;
  final DateTime dataPublicacao;
  final String legenda;
  final String nomeConteudo;
  final String titulo;
  final int curtidas;

  PublicacaoModel({
    required this.id,
    required this.tipoArquivo,
    required this.dataPublicacao,
    required this.legenda,
    required this.nomeConteudo,
    required this.titulo,
    required this.curtidas,
  });
}