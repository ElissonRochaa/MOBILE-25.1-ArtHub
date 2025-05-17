import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaPublicacao extends StatefulWidget {
  const TelaPublicacao({super.key});

  @override
  State<TelaPublicacao> createState() => _TelaPublicacaoState();
}

class _TelaPublicacaoState extends State<TelaPublicacao> {
  bool isCurtido = false;
  bool isImagemAberta = false;
  List<String> comentarios = [];

  Widget post(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Column(
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
                        'assets/images/cat.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text("@esnupi"),
                  SizedBox(width: 220),
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
                            title: Text('Novo comentário'),
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
                                child: Text('Cancelar'),
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
                                child: Text('Enviar'),
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
                    child: Icon(Icons.share_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget comentario(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints: BoxConstraints(minHeight: 69),
        width: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
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
              Text(texto, softWrap: true, overflow: TextOverflow.visible),
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
      backgroundColor: Colors.white,
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
                IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      post(context),
                      ...comentarios
                          .map((texto) => comentario(context, texto))
                          ,
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                      child: Image.asset('assets/images/cat.jpeg'),
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
    );
  }
}
