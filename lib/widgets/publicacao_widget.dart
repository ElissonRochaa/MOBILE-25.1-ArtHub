import 'dart:io';
import 'dart:typed_data';
import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;

class PublicacaoWidget extends StatefulWidget {
  final PublicacaoModel publicacao;

  const PublicacaoWidget({super.key, required this.publicacao});

  @override
  State<PublicacaoWidget> createState() => _PublicacaoWidgetState();
}

class _PublicacaoWidgetState extends State<PublicacaoWidget> {
  Uint8List? _fetchedImageBytes;
  bool _isLoadingMedia = false;
  String? _mediaError;

  VideoPlayerController? _videoController;
  File? _tempVideoFile;

  @override
  void initState() {
    super.initState();
    if (widget.publicacao.tipoArquivo == TipoArquivoEnum.imagem) {
      if (widget.publicacao.id != null) {
        _fetchMediaContent();
      }
    } else if (widget.publicacao.tipoArquivo == TipoArquivoEnum.video) {
      if (widget.publicacao.id != null) {
        _initVideoPreview();
      }
    }
  }

  Future<void> _initVideoPreview() async {
    if (!mounted) return;
    setState(() {
      _isLoadingMedia = true;
    });
    try {
      final videoBytes = await PublicacaoService.getBytes(
        widget.publicacao.id!.toString(),
      );

      if (kIsWeb) {
        final blob = html.Blob([videoBytes], 'video/mp4');
        final url = html.Url.createObjectUrlFromBlob(blob);
        _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      } else {
        final tempDir = await getTemporaryDirectory();
        _tempVideoFile = File(
          '${tempDir.path}/preview_${widget.publicacao.id}.mp4',
        );
        await _tempVideoFile!.writeAsBytes(videoBytes);
        _videoController = VideoPlayerController.file(_tempVideoFile!);
      }

      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.setVolume(0.0);
      _videoController!.play();

      if (mounted) {
        setState(() {
          _isLoadingMedia = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _mediaError = "Erro no preview do vídeo";
          _isLoadingMedia = false;
        });
      }
      print("Erro ao inicializar preview do vídeo: $e");
    }
  }

  Future<void> _fetchMediaContent() async {
    if (mounted) {
      setState(() {
        _isLoadingMedia = true;
        _mediaError = null;
        _fetchedImageBytes = null;
      });
    }
    try {
      if (widget.publicacao.id == null) {
        throw Exception("ID da publicação é nulo.");
      }
      final bytes = await PublicacaoService.getBytes(
        widget.publicacao.id!.toString(),
      );
      if (mounted) {
        setState(() {
          _fetchedImageBytes = bytes;
          _isLoadingMedia = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _mediaError = e.toString();
          _isLoadingMedia = false;
        });
      }
      print("Erro ao buscar mídia (_fetchMediaContent): $e");
    }
  }

  Widget _buildMediaContent(BuildContext context) {
    switch (widget.publicacao.tipoArquivo) {
      case TipoArquivoEnum.imagem:
        if (_isLoadingMedia) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (_mediaError != null) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _mediaError!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ),
          );
        }
        if (_fetchedImageBytes != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.memory(
              _fetchedImageBytes!,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                print("Erro ao decodificar imagem (Image.memory): $error");
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
                widget.publicacao.titulo ?? "Sem título",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.publicacao.nomeConteudo ?? "Nenhum texto disponível.",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      case TipoArquivoEnum.video:
        if (_isLoadingMedia ||
            _videoController == null ||
            !_videoController!.value.isInitialized) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (_mediaError != null) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: Icon(Icons.error_outline)),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/publicacao',
                        arguments: widget.publicacao,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      case TipoArquivoEnum.audio:
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.graphic_eq,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                widget.publicacao.titulo ?? "Áudio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                    'Tipo de arquivo desconhecido ou não suportado: ${widget.publicacao.tipoArquivo.toString().split('.').last}',
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
          arguments: widget.publicacao,
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
              '@${widget.publicacao.perfil.usuario.apelido ?? "Usuário desconhecido"}',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
