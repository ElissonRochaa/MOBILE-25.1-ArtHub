import 'package:flutter/material.dart';

class TelaLogotipo extends StatelessWidget {
  const TelaLogotipo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Text(
          "A logotipo vai aqui", //Mudar quando tiver a logo
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
