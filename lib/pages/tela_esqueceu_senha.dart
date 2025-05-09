import 'package:flutter/material.dart';

import '../config/themeApp.dart';

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
          style: IconButton.styleFrom(backgroundColor: Colors.white),
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
              ).textTheme.displayMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Email',
                labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 20),
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
                'Enviar e-mail',
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
          ],
        ),
      ),
    );
  }
}
