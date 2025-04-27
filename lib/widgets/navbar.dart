import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.search), label: ''),
        NavigationDestination(icon: Icon(Icons.home), label: ''),
        NavigationDestination(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
