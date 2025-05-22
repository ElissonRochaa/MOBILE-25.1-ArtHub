import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/models/perfil_model.dart';

class PublicacaoModel {
  final int id;
  final TipoArquivoEnum tipoArquivo;
  final CategoriaEnum categoria;
  final PerfilModel perfil;
  final DateTime dataPublicacao;
  final String legenda;
  final String nomeConteudo;
  final String titulo;
  final int curtidas;


  PublicacaoModel({
    required this.id,
    required this.tipoArquivo,
    required this.categoria,
    required this.perfil,
    required this.dataPublicacao,
    required this.legenda,
    required this.nomeConteudo,
    required this.titulo,
    required this.curtidas,
  });

  factory PublicacaoModel.fromJson(Map<String, dynamic> json){
    return PublicacaoModel(
    id: json['id'], 
    tipoArquivo: json['tipoArquivo'], 
    categoria: json['categoria'],
    perfil: PerfilModel.fromJson(json['perfil']),
    dataPublicacao: json['dataPublicacao'], 
    legenda: json['legenda'], 
    nomeConteudo: json['nomeConteudo'], 
    titulo: json['titulo'], 
    curtidas: json['curtidas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoArquivo': tipoArquivo,
      'categoria': categoria,
      'perfil': perfil.toJson(),
      'dataPublicacao': dataPublicacao,
      'legenda': legenda,
      'nomeConteudo': nomeConteudo,
      'titulo': titulo,
      'curtidas': curtidas,
    };
  }
}