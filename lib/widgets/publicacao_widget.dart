import 'package:arthub/models/publicacao_model.dart';
import 'package:flutter/material.dart';

class PublicacaoWidget extends StatelessWidget {
  final PublicacaoModel publicacao;

  const PublicacaoWidget({super.key, required this.publicacao});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/publicacao');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/teste2.jpeg', fit: BoxFit.cover),
          ),
          const SizedBox(height: 2),
          Text(
            '@${publicacao.perfil.usuario.apelido}',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
