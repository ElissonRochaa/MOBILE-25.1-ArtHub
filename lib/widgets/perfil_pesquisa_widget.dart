import 'package:flutter/material.dart';

class PerfilPesquisaWidget extends StatelessWidget {
  final String pesquisa;

  const PerfilPesquisaWidget({super.key, required this.pesquisa});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/outro-perfil');
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDA72),
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(10, 10, 10, 0.3),
                offset: Offset(5, 5),
                blurRadius: 2.0,
              ),
            ],
          ),
          width: 332,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/snoopy.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Snoopy chill guy',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '@esnupi',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '10M seguidores',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
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
