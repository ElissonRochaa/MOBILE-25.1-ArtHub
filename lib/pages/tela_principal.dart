import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }
}
