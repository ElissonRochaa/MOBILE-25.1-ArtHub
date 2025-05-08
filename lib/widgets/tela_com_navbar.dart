import 'package:arthub/pages/tela_home.dart';
import 'package:arthub/pages/tela_perfil_usuario.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../pages/tela_ver_perfil_usuario.dart';
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
    TelaHome(),
    TelaPerfilUsuario(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).colorScheme.primary,
        index: currentPageIndex,
        height: 55,
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 50),
          Icon(Icons.person_outline, size: 50),
        ],
        onTap: (index) => {
          setState(() {
            currentPageIndex = index;
            print(currentPageIndex);
          }),
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[currentPageIndex]
    );
  }
}
