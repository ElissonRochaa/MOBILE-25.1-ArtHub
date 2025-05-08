import 'package:flutter/material.dart';

class BotaoAvancarWidget extends StatelessWidget {
  final String texto;
  final String rota;

  const BotaoAvancarWidget({
    super.key,
    required this.texto,
    required this.rota,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(55)),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, rota);
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          texto,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
