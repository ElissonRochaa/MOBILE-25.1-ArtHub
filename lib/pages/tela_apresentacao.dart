import 'dart:ui';
import 'package:arthub/widgets/botao_avancar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Adicione esta linha
import '../provider/modo_tema_provider.dart'; // Adicione esta linha

class TelaApresentacao extends StatelessWidget {
  const TelaApresentacao({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeAppProvider>(context);

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/upe.jpg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Botão para trocar o tema no topo direito
        Positioned(
          top: 30,
          right: 20,
          child: IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: 'Trocar tema',
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
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
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
