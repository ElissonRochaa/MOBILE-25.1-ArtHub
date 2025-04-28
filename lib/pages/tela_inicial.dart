import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:arthub/widgets/navbar_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      body: ListView(
        children: [
          ListaFiltrosWidget(),
          PublicacaoWidget(),
          PublicacaoWidget(),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
