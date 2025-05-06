import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
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
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([ListaFiltrosWidget()]),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 15, right: 12, top: 5),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate([
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                    PublicacaoWidget(),
                  ]),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          if (pesquisa != null && pesquisa.isNotEmpty)
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
