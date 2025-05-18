import 'package:arthub/pages/tela_criar_publicacao.dart';
import 'package:arthub/pages/tela_principal.dart';
import 'package:arthub/pages/tela_proprio_perfil.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/barra_pesquisa_provider.dart';
import 'barra_pesquisa_widget.dart';

class TelaComNavbar extends StatefulWidget {
  final int initialPage;
  final String? userID;

  const TelaComNavbar({super.key, this.initialPage = 0, this.userID});

  @override
  State<TelaComNavbar> createState() => _TelaComNavbarState();
}

class _TelaComNavbarState extends State<TelaComNavbar> {
  late int currentPageIndex = 0;
  late final List<Widget> _pages = [
    TelaPrincipal(),
    TelaCriarPublicacao(),
    TelaProprioPerfil(),
  ];

  @override
  Widget build(BuildContext context) {
    var pesquisa = context.watch<BarraPesquisaProvider>().texto;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.primary,
        index: currentPageIndex,
        height: 55,
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(Icons.home_rounded, size: 50),
          Icon(Icons.add_rounded, size: 50),
          Icon(Icons.person_rounded, size: 50),
        ],
        onTap:
            (index) => {
              setState(() {
                currentPageIndex = index;
              }),
            },
        letIndexChange: (index) => true,
      ),
      body: Stack(
        children: [
          _pages[currentPageIndex],
          if (pesquisa.isNotEmpty)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).colorScheme.surface!.withOpacity(0.95),
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
