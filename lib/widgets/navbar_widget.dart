import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: '',
        ),
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
