import 'package:flutter/material.dart';
import '../models/perfil_model.dart';

class PerfilPesquisaWidget extends StatelessWidget {
  final PerfilModel perfil;

  const PerfilPesquisaWidget({super.key, required this.perfil});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = 'http://localhost:8080${perfil.fotoPerfil}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/outro-perfil',
            arguments: perfil.usuario.id,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {},
                child:
                    perfil.fotoPerfil == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    perfil.usuario.nome,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@${perfil.usuario.apelido}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
