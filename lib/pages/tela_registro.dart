import 'package:arthub/api/api_client.dart';
import 'package:arthub/models/cadastro_model.dart';
import 'package:arthub/services/auth_service.dart';
import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:arthub/widgets/stackbar.dart';
import 'package:arthub/widgets/input_texto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

bool isEmailValid(String email) {
  return email.endsWith('@upe.br');
}

class TelaRegistro extends StatefulWidget {
  const TelaRegistro({super.key});

  @override
  State<TelaRegistro> createState() => _TelaRegistroState();
}

class _TelaRegistroState extends State<TelaRegistro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _apelidoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _dataNascimentoController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
  // Validação dos campos vazios
  if (_nomeController.text.isEmpty ||
      _apelidoController.text.isEmpty ||
      _telefoneController.text.isEmpty ||
      _emailController.text.isEmpty ||
      _senhaController.text.isEmpty ||
      _dataNascimentoController.text.isEmpty) {
    showCustomSnackBar(context, 'Por favor, preencha todos os campos');
    return;
  }

  // Validação do email
  if (!isEmailValid(_emailController.text)) {
    showCustomSnackBar(context, 'O email deve terminar com @upe.br');
    return;
  }

  try {
    final cadastro = CadastroModel(
      nome: _nomeController.text,
      apelido: _apelidoController.text,
      telefone: _telefoneController.text,
      email: _emailController.text,
      senha: _senhaController.text,
      dataNascimento: _dataNascimentoController.text,
    );

    await AuthService.cadastrarUsuario(cadastro);

    showCustomSnackBar(context, 'Cadastro realizado com sucesso!');
    Navigator.pushReplacementNamed(context, '/login');

  } catch (e) {
      showCustomSnackBar(context, 'Cadastro não realizado! Algo deu errado!');
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
                        controller: _nomeController,
                        inputTipo: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Apelido",
                        hintLabel: "Digite seu apelido",
                        controller: _apelidoController,
                        inputTipo: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Telefone",
                        hintLabel: "Digite seu telefone",
                        inputTipo: TextInputType.phone,
                        controller: _telefoneController,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Email",
                        hintLabel: "Digite seu email",
                        inputTipo: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        hintLabel: "Data de Nascimento",
                        label: "Data de Nascimento",
                        inputTipo: TextInputType.datetime,
                        controller: _dataNascimentoController,
                      ),
                      const SizedBox(height: 20),
                      InputTexto(
                        label: "Senha",
                        hintLabel: "Digite sua senha",
                        inputTipo: TextInputType.visiblePassword,
                        controller: _senhaController,
                      ),
                      const SizedBox(height: 40),
                      BotaoEstilizadoWidget(
                        funcao: _registrar,
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
