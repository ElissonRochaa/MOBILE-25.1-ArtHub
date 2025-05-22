import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:arthub/widgets/input_texto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TelaRegistro extends StatelessWidget {
  const TelaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/upe.jpg'),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.modulate,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          Positioned(left: 10, top: 10, child: BotaoVoltarWidget()),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: SingleChildScrollView(
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
                        label: "Telefone",
                        hintLabel: "Digite seu telefone",
                        inputTipo: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Email",
                        hintLabel: "Digite seu email",
                        inputTipo: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        hintLabel: "Data de Nascimento",
                        label: "Data de Nascimento",
                        inputTipo: TextInputType.datetime,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Senha",
                        hintLabel: "Digite sua senha",
                        inputTipo: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 40),
                      BotaoEstilizadoWidget(
                        funcao: () => {Navigator.pushNamed(context, '/login')},
                        texto: 'Registre-se',
                      ),
                      const SizedBox(height: 60),
                      RichText(
                        text: TextSpan(
                          text: "Já é Cadastrado? ",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          children: [
                            TextSpan(
                              text: "Faça o Login!",
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
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
                        margin: const EdgeInsets.only(top: 20),
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
          ),
        ],
      ),
    );
  }
}
