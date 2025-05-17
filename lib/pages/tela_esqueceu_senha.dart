import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:flutter/material.dart';


class TelaEsqueceuSenha extends StatelessWidget {
  const TelaEsqueceuSenha({super.key});

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
                image: AssetImage('assets/images/upe_entrada.jpeg'),
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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
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
                      labelStyle: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(
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
                  BotaoEstilizadoWidget(funcao: () => {
                    Navigator.pushNamed(context, '/login')
                  }, texto: 'Enviar e-mail')
                ],
              ),
            ),
          ),
          Positioned(top: 750, left: 160,
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
          ))
        ],
      ),
    );
  }
}
