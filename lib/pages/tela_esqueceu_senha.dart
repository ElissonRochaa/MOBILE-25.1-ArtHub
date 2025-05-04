import 'package:flutter/material.dart';

class TelaEsqueceuSenha extends StatelessWidget {
  const TelaEsqueceuSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            Text(
              'Informe seu email cadastrado para receber instruções de recuperação de senha:',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Colors.white,
                elevation: 10,
              ),
              onPressed: () {
                print('botão de Enviar Email clicado');
              },
              child: const Text(
                'Enviar email',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 2,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
