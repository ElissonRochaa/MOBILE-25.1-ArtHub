import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:flutter/material.dart';

class TelaPost extends StatelessWidget {
  const TelaPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget()),
      body: SingleChildScrollView(
          child: Column(
            children: [
              ListaFiltrosWidget(),
            ],
          )
        ),
    );
  }
}
