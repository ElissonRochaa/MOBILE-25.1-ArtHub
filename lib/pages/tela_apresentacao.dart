import 'package:flutter/material.dart';

class TelaApresentacao extends StatelessWidget {
  const TelaApresentacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FittedBox(child: Image.asset('assets/images/upe_entrada.jpeg')),
          ],
        ),
      ),
    );
  }
}
