import 'dart:typed_data';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/rodape_widget.dart';

class TelaPublicacao extends StatefulWidget {
  final PublicacaoModel publicacao;

  const TelaPublicacao({super.key, required this.publicacao});

  @override
  State<TelaPublicacao> createState() => _TelaPublicacaoState();
}

class _TelaPublicacaoState extends State<TelaPublicacao> {
  bool isCurtido = false;
  bool isImagemAberta = false;
  bool lertudo = false;
  List<String> comentarios = [];

  Uint8List? _fetchedImageBytes;
  bool _isLoadingImage = true;
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _fetchPublicacaoImage();
  }

  Future<void> _fetchPublicacaoImage() async {
    if (mounted) {
      setState(() {
        _isLoadingImage = true;
        _imageError = null;
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
          _isLoadingImage = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _imageError = e.toString();
          _isLoadingImage = false;
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
                _tags(context, 'Fotografia'),
                _tags(context, 'Escultura'),
                _tags(context, 'Escultura'),
                _tags(context, 'Escultura'),
                _tags(context, 'Escultura'),
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
                      widget.publicacao.legenda ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                    : Text(
                      widget.publicacao.legenda ?? '',
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

  Widget _buildImageWidget() {
    if (_isLoadingImage) {
      return Center(child: CircularProgressIndicator());
    }
    if (_imageError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Erro ao carregar imagem: $_imageError',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      );
    }
    if (_fetchedImageBytes != null) {
      return Image.memory(
        _fetchedImageBytes!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Erro ao decodificar imagem (Image.memory): $error");
          return Center(
            child: Icon(
              Icons.broken_image,
              size: 50,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
  }

  Widget _post(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 135),
          child: Text(
            widget.publicacao.titulo ?? '',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 335, maxHeight: 335),
              child: GestureDetector(
                onTap: () {
                  if (_fetchedImageBytes != null && _imageError == null) {
                    setState(() {
                      isImagemAberta = true;
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImageWidget(),
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
                      widget.publicacao.perfil.usuario.apelido,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    // Agrupa os ícones
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
          Positioned(top: 19, left: 10, child: BotaoVoltarWidget()),
          if (isImagemAberta && _fetchedImageBytes != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  isImagemAberta = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4,
                        child: Image.memory(_fetchedImageBytes!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (pesquisa.isNotEmpty)
            Positioned.fill(
              child: Container(
                color: Colors.white.withValues(alpha: 0.95),
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
        ],
      ),
      bottomNavigationBar: RodapeWidget(),
    );
  }
}
