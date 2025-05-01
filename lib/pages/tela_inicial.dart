import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:arthub/widgets/navbar_widget.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    var pesquisa = context.watch<BarraPesquisaProvider>().texto;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      body: Stack(
        children: [
          ListView(
            children: const [
              ListaFiltrosWidget(),
              PublicacaoWidget(),
              PublicacaoWidget(),
            ],
          ),
          if (pesquisa != null && pesquisa.isNotEmpty)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.95), // leve opacidade
                child: PerfilPesquisaWidget(pesquisa: pesquisa),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
