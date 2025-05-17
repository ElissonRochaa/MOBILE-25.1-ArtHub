import 'package:flutter/material.dart';

class BotaoEstilizadoWidget extends StatelessWidget {
  final VoidCallback funcao;
  final String texto;

  const BotaoEstilizadoWidget({
    super.key,
    required this.funcao,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: funcao,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          shadows: [
            Shadow(
              color: Color.fromRGBO(10, 10, 10, 0.3),
              offset: Offset(0, 3),
              blurRadius: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
