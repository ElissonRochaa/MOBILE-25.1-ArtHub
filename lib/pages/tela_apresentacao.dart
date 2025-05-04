import 'dart:ui';
import 'package:arthub/widgets/botao_avancar_widget.dart';
import 'package:flutter/material.dart';

class TelaApresentacao extends StatelessWidget {
  const TelaApresentacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/upe_entrada.jpeg'),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.modulate,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 264,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        "Um universo de arte na palma da sua mão.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 75,
                          height: 33,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo_upe.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        BotaoAvancarWidget(
                          texto: "Avançar",
                          rota: "/login", //Organizar as rotas depois!
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
