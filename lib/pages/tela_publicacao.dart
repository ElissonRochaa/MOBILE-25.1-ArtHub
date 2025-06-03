import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/provider/barra_pesquisa_provider.dart';
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
          ),
        ),
        Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 335, maxHeight: 335),
              child: GestureDetector(
                onTap:
                    () => {
                      setState(() {
                        isImagemAberta = true;
                      }),
                    },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      widget.publicacao.nomeConteudo ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Row(
                children: [
                  Text(
                    widget.publicacao.perfil.usuario.apelido,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width - 200),
                  GestureDetector(
                    onTap:
                        () => {
                          setState(() {
                            isCurtido = !isCurtido;
                          }),
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
                                color: Theme.of(context).colorScheme.onPrimary,
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
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    comentarios.add(controller.text);
                                  });
                                  Navigator.of(context).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.mode_comment_outlined),
                  ),
                  GestureDetector(
                    onTap: () => {print("Botão de compartilhar foi clicado")},
                    child: Icon(
                      Icons.share_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
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
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints: BoxConstraints(minHeight: 69),
        width: 335,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      _post(context),
                      ...comentarios.map(
                        (texto) => _comentario(context, texto),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(top: 19, left: 10, child: BotaoVoltarWidget()),
          if (isImagemAberta)
            GestureDetector(
              onTap:
                  () => {
                    setState(() {
                      isImagemAberta = false;
                    }),
                  },
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Image.asset('assets/images/teste2.jpeg'),
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
