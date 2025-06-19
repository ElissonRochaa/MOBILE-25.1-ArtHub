import 'package:arthub/widgets/stackbar.dart';
import 'package:flutter/material.dart';
import 'package:arthub/services/email_service.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';

class TelaEsqueceuSenha extends StatefulWidget {
  const TelaEsqueceuSenha({super.key});

  @override
  State<TelaEsqueceuSenha> createState() => _TelaEsqueceuSenhaState();
}

class _TelaEsqueceuSenhaState extends State<TelaEsqueceuSenha> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _enviarEmailRecuperacao() async {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      showCustomSnackBar(context, "Email vazio ou inválido.");
      return;
    }

    setState(() => _isLoading = true);
    
    final resposta = await EmailService.solicitarRecuperacaoSenha(email);

    showCustomSnackBar(context, resposta);

    setState(() => _isLoading = false);
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

          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 150,
            left: 20,
            right: 20,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Informe seu email cadastrado para receber instruções de recuperação de senha:',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      labelText: 'Email',
                      labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _enviarEmailRecuperacao,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Enviar email'),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 750,
            left: 160,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
