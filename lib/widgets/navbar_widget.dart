import 'package:arthub/pages/tela_de_perfil.dart';
import 'package:arthub/pages/tela_inicial.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  final List<Widget> _children = [TelaInicial(), TelaDePerfil()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: '',
        ),
      ],
    );
  }
}
