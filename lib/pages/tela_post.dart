import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:flutter/material.dart';

class TelaPost extends StatefulWidget {
  const TelaPost({super.key});

  @override
  State<TelaPost> createState() => _TelaPostState();
}

class _TelaPostState extends State<TelaPost> {
  bool isCurtido = false;

  Widget post(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 335,
                  maxHeight: 335,
                ),
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
              Row(
                children: [
                  Text("@esnupi"),
                  SizedBox(
                    width: 220,
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        isCurtido = !isCurtido;
                      })
                    },
                    child: isCurtido ? Icon(Icons.favorite_rounded) : Icon(Icons.favorite_border_rounded),
                  ),
                  GestureDetector(
                    onTap: () => {print("Botão de compartilhar foi clicado")},
                    child: Icon(Icons.share),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget comentario(BuildContext context, String texto){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 69
        ),
        width: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            )
          ],
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('@mikeymouse'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  texto,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                )
              ],
            ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget()),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => {print("Botão de voltar apertado")},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  )
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    post(context),
                    comentario(context, "Um texto curtinho"),
                    comentario(context, "Um texto muito muito longo Um texto muito muito longo Um texto muito muito longo Um texto muito muito longo"),
                    comentario(context, "Um texto muito muito longo Um texto muito muito longo Um texto muito muito longo Um texto muito muito longo"),
                    comentario(context, "Um texto curtinho"),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }
}
