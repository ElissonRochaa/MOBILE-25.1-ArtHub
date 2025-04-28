import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/navbar_widget.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:flutter/material.dart';

class TelaDePesquisa extends StatelessWidget {
  const TelaDePesquisa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          PerfilPesquisaWidget(),
          SizedBox(height: 5),
          PerfilPesquisaWidget(),
          SizedBox(height: 5),
          PerfilPesquisaWidget(),
          SizedBox(height: 5),
          PerfilPesquisaWidget(),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
