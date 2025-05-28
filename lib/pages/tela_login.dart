import 'package:arthub/models/dtos/login_dto.dart';
import 'package:arthub/services/usuario_service.dart';
import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:arthub/widgets/input_texto.dart';
import 'package:arthub/widgets/stackbar.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void dipose() {
      _emailController.dispose();
      _senhaController.dispose();
      super.dispose();
    }

    Future<void> _login() async {
      try {
        final usuarioLogin = LoginDTO(
          email: _emailController.text,
          senha: _senhaController.text,
        );
        final response = await UsuarioService.login(usuarioLogin);

        if (response.isNotEmpty) {
          showCustomSnackBar(context, 'Login realizado com sucesso!');
          Navigator.pushNamed(context, '/home');
        } else {
          showCustomSnackBar(context, 'Email ou senha incorretos!');
        }
      } catch (e) {
        showCustomSnackBar(context, 'Falha nas credencias! Tente novamente');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: BotaoVoltarWidget(),
                    ),
                  ),
                  SizedBox(height: 150),
                  InputTexto(
                    label: 'Email',
                    hintLabel: 'seumelhoremail@gmail.com',
                    controller: _emailController,
                  ),
                  SizedBox(height: 50),
                  InputTexto(
                    label: 'Senha',
                    hintLabel: 'MuitoSecreta',
                    controller: _senhaController,
                    ehOculto: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:
                            () => {
                              Navigator.pushNamed(context, '/esqueceu-senha'),
                            },
                        child: Text(
                          'Esqueceu a senha?',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  BotaoEstilizadoWidget(funcao: _login, texto: 'Fazer Login'),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem uma conta?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      SizedBox(width: 3),
                      GestureDetector(
                        onTap:
                            () => {Navigator.pushNamed(context, '/registro')},
                        child: Text(
                          'Registre-se!',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
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
          ],
        ),
      );
    }
  }
