import 'package:arthub/pages/tela_de_perfil.dart';
import 'package:arthub/pages/tela_inicial.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
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
