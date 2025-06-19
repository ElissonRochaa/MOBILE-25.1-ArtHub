import 'package:arthub/widgets/stackbar.dart';
import 'package:flutter/material.dart';
import 'package:arthub/services/auth_service.dart';
import 'package:arthub/widgets/input_texto.dart';

class TelaResetarSenha extends StatefulWidget {
  const TelaResetarSenha({super.key});

  @override
  State<TelaResetarSenha> createState() => _TelaResetarSenhaState();
}

class _TelaResetarSenhaState extends State<TelaResetarSenha> {
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;
  String? email;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = Uri.base;
      print('🌐 Uri.base: $uri');

      // Extrai fragmento após o #
      final fragment = uri.fragment;
      print('🔍 Fragment: $fragment');

      // Divide o fragmento em caminho e query
      final parts = fragment.split('?');
      final fragmentUri =
          parts.length > 1
              ? Uri.parse('http://localhost/?${parts[1]}')
              : Uri.parse('http://localhost/');

      final queryEmail = fragmentUri.queryParameters['email'];
      print('✉️ queryEmail: $queryEmail');

      if (queryEmail == null || queryEmail.isEmpty) {
        showCustomSnackBar(context, 'Link inválido ou expirado.');
      } else {
        setState(() {
          email = queryEmail;
        });
      }
    });
  }

  Future<void> _resetarSenha() async {
    final novaSenha = _senhaController.text.trim();

    if (email == null || email!.isEmpty) {
      showCustomSnackBar(context, 'Email inválido ou ausente no link.');
      return;
    }

    setState(() => _isLoading = true);

    final resposta = await AuthService.redefinirSenha(email!, novaSenha);

    showCustomSnackBar(context, "Senha alterada!");

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          email == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  // Fundo com imagem
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

                  // Camada superior arredondada
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

                  // Conteúdo principal
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 150,
                    left: 20,
                    right: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            'Digite sua nova senha:',
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          InputTexto(label: "Nova Senha", 
                          hintLabel: "Digite sua nova senha:", 
                          inputTipo: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _resetarSenha,
                            child:
                                _isLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : const Text('Redefinir senha'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Logo UPE
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
