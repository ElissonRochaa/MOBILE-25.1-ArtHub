import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/models/perfil_model.dart';

class PublicacaoModel {
  final TipoArquivoEnum tipoArquivo;
  final String? legenda;
  final String? nomeConteudo;
  final String? titulo;
  final CategoriaEnum categoria;
  final int curtidas;
  final PerfilModel perfil;
  final List<PerfilModel> perfisQueCurtiram;

  PublicacaoModel({
    required this.tipoArquivo,
    required this.legenda,
    required this.nomeConteudo,
    required this.titulo,
    required this.categoria,
    required this.curtidas,
    required this.perfil,
    required this.perfisQueCurtiram,
  });

  factory PublicacaoModel.fromJson(Map<String, dynamic> json){
    return PublicacaoModel(
    tipoArquivo: json['tipoArquivo'], 
    legenda: json['legenda'],
    nomeConteudo: json['nomeConteudo'],
    titulo: json['titulo'],
    categoria: json['categoria'],
    curtidas: json['curtidas'],
    perfil: PerfilModel.fromJson(json['perfil']),
    perfisQueCurtiram: (json['perfisQueCurtiram'] as List)
      .map((perfil) => PerfilModel.fromJson(perfil))
      .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipoArquivo': tipoArquivo,
      'categoria': categoria,
      'perfil': perfil.toJson(),
      'perfisQueCurtiram': perfisQueCurtiram.map(
              (perfil) => perfil.toJson()).toList(),
      'legenda': legenda,
      'nomeConteudo': nomeConteudo,
      'titulo': titulo,
      'curtidas': curtidas,
    };
  }
}