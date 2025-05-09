import 'package:arthub/widgets/input_texto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../config/themeApp.dart';

class TelaRegistro extends StatelessWidget {
  const TelaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    InputTexto(
                      label: "Nome",
                      hintLabel: "Digite seu nome completo",
                    ),
                    const SizedBox(height: 20),
                    InputTexto(
                      label: "Apelido",
                      hintLabel: "Digite seu apelido",
                    ),
                    const SizedBox(height: 20),
                    InputTexto(
                      label: "Data de Nascimento",
                      hintLabel: "Digite sua data de nascimento",
                      inputTipo: TextInputType.datetime,
                    ),
                    const SizedBox(height: 20),
                    InputTexto(label: "Email", hintLabel: "Digite seu email"),
                    const SizedBox(height: 20),
                    InputTexto(label: "Senha", hintLabel: "Digite sua senha"),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => {Navigator.pushNamed(context, "/login")},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(165, 46),
                        backgroundColor: ThemeApp.theme.colorScheme.tertiary,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Cadastrar-se',
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
                    ),
                    const SizedBox(height: 80),
                    RichText(
                      text: TextSpan(
                        text: "Já é Cadastrado? ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: "Faça o Login!",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 35),
                      width: 75,
                      height: 33,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo_upe.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
