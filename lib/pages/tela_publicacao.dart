import 'dart:typed_data';
import 'package:arthub/enums/tipo_arquivo_enum.dart';
import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/services/token_service.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../widgets/rodape_widget.dart';

class TelaPublicacao extends StatefulWidget {
  final PublicacaoModel publicacao;

  const TelaPublicacao({super.key, required this.publicacao});

  @override
  State<TelaPublicacao> createState() => _TelaPublicacaoState();
}

class MyCustomAudioSource extends StreamAudioSource {
  final Uint8List bytes;

  MyCustomAudioSource(this.bytes) : super(tag: 'MyCustomAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}

class _TelaPublicacaoState extends State<TelaPublicacao> {
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  bool isCurtido = false;
  bool isImagemAberta = false;
  bool lertudo = false;
  List<String> comentarios = [];

  Uint8List? _fetchedMediaBytes;
  bool _isLoadingMedia = true;
  String? _mediaError;

  final _audioPlayer = AudioPlayer();
  String? _userEmailLogado;
  late PublicacaoModel _publicacaoAtual;

  String categoriaToTexto(CategoriaEnum categoria) {
    switch (categoria) {
      case CategoriaEnum.poema:
        return 'Poema';
      case CategoriaEnum.musica:
        return 'Música';
      case CategoriaEnum.pintura:
        return 'Pintura';
      case CategoriaEnum.desenho:
        return 'Desenho';
      case CategoriaEnum.escultura:
        return 'Escultura';
      case CategoriaEnum.fotografia:
        return 'Fotografia';
      default:
        return categoria.name;
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.publicacao.tipoArquivo) {
      case TipoArquivoEnum.imagem:
        _fetchMediaContent();
        break;
      case TipoArquivoEnum.audio:
        _initAudioPlayer();
        break;
      case TipoArquivoEnum.texto:
        if (mounted) {
          setState(() {
            _isLoadingMedia = false;
          });
        }
        break;
      default:
        if (mounted) {
          setState(() {
            _isLoadingMedia = false;
            _mediaError = "Tipo de arquivo não suportado";
          });
        }
    }
    _publicacaoAtual = widget.publicacao;
    _buscarPublicacaoAtualizada();
    _carregarUsuarioLogado();
  }

  Future<void> _buscarPublicacaoAtualizada() async {
    try {
      final nova = await PublicacaoService.getById(widget.publicacao.id);
      if (mounted) {
        setState(() {
          _publicacaoAtual = nova;
        });
        _fetchMediaContent();
      }
    } catch (e) {
      print('Erro ao buscar publicação atualizada: $e');
    }
  }

  Future<void> _carregarUsuarioLogado() async {
    try {
      String email = await TokenService.decodeToken();
      if (mounted) {
        setState(() {
          _userEmailLogado = email;
          print("Usuário logado email: $_userEmailLogado");
        });
      }
    } catch (e) {
      print("Erro ao obter usuário logado: $e");
    }
  }

  Future<void> _initAudioPlayer() async {
    if (mounted) {
      setState(() {
        _isLoadingMedia = true;
        _mediaError = null;
      });
    }
    try {
      if (widget.publicacao.id == null) {
        throw Exception("ID da publicação é nulo.");
      }

      final bytes = await PublicacaoService.getBytes(
        widget.publicacao.id!.toString(),
      );

      final audioSource = MyCustomAudioSource(bytes);

      await _audioPlayer.setAudioSource(audioSource);

      if (mounted) {
        setState(() {
          _isLoadingMedia = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _mediaError = "Erro ao carregar áudio: ${e.toString()}";
          _isLoadingMedia = false;
        });
      }
      print("Erro ao inicializar áudio (_initAudioPlayer): $e");
    }
  }

  Future<void> _fetchMediaContent() async {
    if (mounted) {
      setState(() {
        _isLoadingMedia = true;
        _mediaError = null;
        _fetchedMediaBytes = null;
      });
    }
    try {
      if (_publicacaoAtual.id == null) {
        throw Exception("ID da publicação é nulo.");
      }
      final bytes = await PublicacaoService.getBytes(
        _publicacaoAtual.id!.toString(),
      );
      if (mounted) {
        setState(() {
          _fetchedMediaBytes = bytes;
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
      print("Erro ao buscar imagem da publicação: $e");
    }
  }

  Widget _tags(BuildContext context, String texto) {
    return Container(
      margin: EdgeInsets.only(right: 4, left: 4),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Center(
        child: Text(
          texto,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget _descricaoETag(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _tags(context, categoriaToTexto(_publicacaoAtual.categoria)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                lertudo = !lertudo;
              });
            },
            child:
                lertudo
                    ? Text(
                      _publicacaoAtual.legenda ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                    : Text(
                      _publicacaoAtual.legenda ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
          ),
          SizedBox(height: 8),
          Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildMediaWidget() {
    switch (widget.publicacao.tipoArquivo) {
      case TipoArquivoEnum.imagem:
        if (_isLoadingMedia) {
          return Center(child: CircularProgressIndicator());
        }
        if (_mediaError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Erro ao carregar imagem: $_mediaError',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }
        if (_fetchedMediaBytes != null) {
          return Image.memory(
            _fetchedMediaBytes!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              );
            },
          );
        }
        return Center(
          child: Icon(
            Icons.image_not_supported,
            size: 50,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        );
      case TipoArquivoEnum.texto:
        return Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: Text(
            widget.publicacao.nomeConteudo ?? "Nenhum texto disponível.",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      case TipoArquivoEnum.audio:
        if (_isLoadingMedia) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        if (_mediaError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Erro ao carregar áudio:\n$_mediaError',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;

                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: const Icon(Icons.play_arrow_rounded),
                      iconSize: 64,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: _audioPlayer.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: const Icon(Icons.pause_rounded),
                      iconSize: 64,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: _audioPlayer.pause,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.replay_rounded),
                      iconSize: 64,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => _audioPlayer.seek(Duration.zero),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              StreamBuilder<Duration?>(
                stream: _audioPlayer.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return Column(
                        children: [
                          Slider(
                            min: 0.0,
                            max: duration.inMilliseconds.toDouble() + 1.0,
                            value: position.inMilliseconds.toDouble(),
                            onChanged: (value) {
                              _audioPlayer.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                            inactiveColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(position),
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                  ),
                                ),
                                Text(
                                  _formatDuration(duration),
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      default:
        return Center(
          child: Text(
            'Tipo de conteúdo não suportado.',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        );
    }
  }

  Widget _post(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _publicacaoAtual.titulo ?? '',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 335,
                maxHeight:
                    widget.publicacao.tipoArquivo == TipoArquivoEnum.texto
                        ? double.infinity
                        : 355,
              ),
              child: GestureDetector(
                onTap: () {
                  if (widget.publicacao.tipoArquivo == TipoArquivoEnum.imagem &&
                      _fetchedMediaBytes != null &&
                      _mediaError == null) {
                    setState(() {
                      isImagemAberta = true;
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildMediaWidget(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 20, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '@${_publicacaoAtual.perfil.usuario.apelido ?? "Usuário desconhecido"}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCurtido = !isCurtido;
                          });
                        },
                        child:
                            isCurtido
                                ? Icon(Icons.favorite_rounded)
                                : Icon(Icons.favorite_border_rounded),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              TextEditingController controller =
                                  TextEditingController();
                              return AlertDialog(
                                title: Text(
                                  'Novo comentário',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                content: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintText: "Digite seu comentário",
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  maxLines: 3,
                                ),
                                actions: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: BorderSide(width: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (controller.text.isNotEmpty) {
                                        setState(() {
                                          comentarios.add(controller.text);
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      foregroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text('Enviar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.mode_comment_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          print("Botão de compartilhar foi clicado");
                        },
                        child: Icon(
                          Icons.share_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 33, right: 33, top: 10),
              child: _descricaoETag(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _comentario(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 33, right: 33),
      child: Container(
        constraints: BoxConstraints(minHeight: 69),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onTertiary,
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('@mikeymouse'),
              SizedBox(height: 10),
              Text(
                texto,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDono =
        _userEmailLogado != null &&
        _publicacaoAtual.perfil.usuario.email.toString() == _userEmailLogado;

    var pesquisa = context.watch<BarraPesquisaProvider>().texto;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Conteúdo principal
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                _post(context),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    return _comentario(context, comentarios[index]);
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Botão voltar
          Positioned(top: 19, left: 10, child: BotaoVoltarWidget()),
          // Imagem ampliada
          if (isImagemAberta && _fetchedMediaBytes != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isImagemAberta = false;
                  });
                },
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4,
                        child: Image.memory(_fetchedMediaBytes!),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          if (pesquisa.isNotEmpty)
            Positioned.fill(
              child: Container(
                color: Colors.white.withAlpha(242),
                child: Column(
                  children: [
                    PerfilPesquisaWidget(pesquisa: pesquisa),
                    PerfilPesquisaWidget(pesquisa: pesquisa),
                    PerfilPesquisaWidget(pesquisa: pesquisa),
                    PerfilPesquisaWidget(pesquisa: pesquisa),
                  ],
                ),
              ),
            ),
          if (isDono == true && !isImagemAberta)
            Positioned(
              bottom: 32,
              right: 24,
              child: GestureDetector(
                onTap: () async {
                  final editada = await Navigator.pushNamed(
                    context,
                    '/tela_editar_publicacao',
                    arguments: _publicacaoAtual,
                  );
                  if (editada != null && mounted) {
                    setState(() {
                      _publicacaoAtual = editada as PublicacaoModel;
                    });
                    _fetchMediaContent();
                  }
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: RodapeWidget(),
    );
  }
}
