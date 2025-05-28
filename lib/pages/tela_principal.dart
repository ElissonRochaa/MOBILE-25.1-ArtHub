import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TelaPrincipal extends StatelessWidget {
  TelaPrincipal({super.key});

  final List<String> imagens = [
    'assets/images/teste1.jpeg',
    'assets/images/teste2.jpeg',
    'assets/images/cat.jpeg',
    'assets/images/hannah.jpg',
    'assets/images/snoopy.jpeg',
  ];

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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childCount: 14,
                itemBuilder: (context, index) {
                  final imagePath = imagens[index % imagens.length];

                  return PublicacaoWidget(imagePath: imagePath);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
