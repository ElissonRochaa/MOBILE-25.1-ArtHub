import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
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
          width: 250,
          child: Column(
            children: [
              Container(
                width: 335,
                height: 335,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cat.jpeg'),
                    fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("@esnupi"),
                  Row(
                    children: [
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
              )
            ],
          ),
        ),
      ],
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
              ListaFiltrosWidget(),
              IconButton(
                  onPressed: () => {print("Botão de voltar apertado")},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  )
              ),
              SingleChildScrollView(
                child: post(context),
              ),
            ],
          )
        ),
    );
  }
}
