import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/models/perfil_model.dart';

class PublicacaoModel {
  final int id;
  final TipoArquivoEnum tipoArquivo;
  final String? legenda;
  final String? nomeConteudo;
  final String? titulo;
  final CategoriaEnum categoria;
  final int curtidas;
  final PerfilModel perfil;
  final List<PerfilModel> perfisQueCurtiram;

  PublicacaoModel({
    required this.id,
    required this.tipoArquivo,
    required this.legenda,
    required this.nomeConteudo,
    required this.titulo,
    required this.categoria,
    required this.curtidas,
    required this.perfil,
    required this.perfisQueCurtiram,
  });

  factory PublicacaoModel.fromJson(Map<String, dynamic> json) {
    return PublicacaoModel(
      id: json['id'],
      tipoArquivo: toTipoArquivoEnum(json),
      legenda: json['legenda'],
      nomeConteudo: json['nomeConteudo'],
      titulo: json['titulo'],
      categoria: toCategoriaEnum(json),
      curtidas: json['curtidas'],
      perfil: PerfilModel.fromJson(json['perfil']),
      perfisQueCurtiram:
          (json['perfisQueCurtiram'] as List)
              .map((perfil) => PerfilModel.fromJson(perfil))
              .toList(),
    );
  }

  static CategoriaEnum toCategoriaEnum(Map<String, dynamic> json) {
    String categoria = json['categoria'];
    switch (categoria) {
      case 'POEMA':
        return CategoriaEnum.poema;
      case 'MUSICA':
        return CategoriaEnum.musica;
      case 'PINTURA':
        return CategoriaEnum.pintura;
      case 'DESENHO':
        return CategoriaEnum.desenho;
      case 'ESCULTURA':
        return CategoriaEnum.escultura;
      case 'FOTOGRAFIA':
        return CategoriaEnum.fotografia;
      default:
        throw Exception("Algo deu errado no toCategoriaEnum");
    }
  }

  static TipoArquivoEnum toTipoArquivoEnum(Map<String, dynamic> json) {
    String tipoArquivo = json['tipoArquivo'];
    switch (tipoArquivo) {
      case 'IMAGEM':
        return TipoArquivoEnum.imagem;
      case 'VIDEO':
        return TipoArquivoEnum.video;
      case 'TEXTO':
        return TipoArquivoEnum.texto;
      case 'AUDIO':
        return TipoArquivoEnum.audio;
      default:
        throw Exception('Algo deu errado no toTipoArquivoEnum');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoArquivo': tipoArquivo,
      'categoria': categoria,
      'perfil': perfil.toJson(),
      'perfisQueCurtiram':
          perfisQueCurtiram.map((perfil) => perfil.toJson()).toList(),
      'legenda': legenda,
      'nomeConteudo': nomeConteudo,
      'titulo': titulo,
      'curtidas': curtidas,
    };
  }

  Map<String, dynamic> toEditJson() {
    //Model do Put
    return {
      'id': id,
      'categoria':
          categoria.name.toUpperCase(), //Categoria é um ENUM, é tudo maiúsculo
      'legenda': legenda,
      'nomeConteudo': nomeConteudo,
      'titulo': titulo,
    };
  }
}
