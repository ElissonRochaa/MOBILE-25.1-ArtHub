import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/pages/tela_publicacao.dart';
import 'package:flutter/material.dart';

class PublicacaoWidget extends StatelessWidget {
  final PublicacaoModel publicacao;

  const PublicacaoWidget({super.key, required this.publicacao});

  Widget _buildMediaContent(BuildContext context) {
    switch (publicacao.tipoArquivo) {
      case TipoArquivoEnum.imagem:
        if (publicacao.nomeConteudo != null &&
            publicacao.nomeConteudo!.isNotEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              publicacao.nomeConteudo!,
              fit: BoxFit.fitWidth,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  ),
                );
              },
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 200,
              color: Theme.of(context).colorScheme.onSecondary,
              child: Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 48,
                ),
              ),
            ),
          );
        }
      case TipoArquivoEnum.texto:
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publicacao.titulo ?? "Sem título",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                publicacao.nomeConteudo ?? "Nenhum texto disponível.",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 150,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 40,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tipo de arquivo desconhecido ou não suportado: ${publicacao.tipoArquivo.toString().split('.').last}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/publicacao',
          arguments: {'publicacao': publicacao},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMediaContent(context),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '@${publicacao.perfil.usuario.apelido}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
