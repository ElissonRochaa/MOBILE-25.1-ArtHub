import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/botao_voltar_widget.dart';
import 'package:flutter/material.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool estaOculto = true;

  Widget inputDeTexto(
    BuildContext context,
    String label,
    String hintText,
    bool oculto,
  ) {
    return Container(
      width: 346,
      height: 79,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(10, 10, 10, 0.3),
            offset: Offset(6, 6),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: TextFormField(
        obscureText: oculto,
        decoration: InputDecoration(
          label: Text(
            label,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
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
                inputDeTexto(
                  context,
                  'Email',
                  'seumelhoremail@gmail.com',
                  false,
                ),
                SizedBox(height: 50),
                inputDeTexto(context, 'Senha', 'MuitoSecreta', estaOculto),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    estaOculto
                        ? Icon(
                          color: Theme.of(context).colorScheme.surface,
                          Icons.remove_red_eye_outlined,
                        )
                        : Icon(Icons.remove_red_eye),
                    GestureDetector(
                      onTap:
                          () => {
                            setState(() {
                              estaOculto = !estaOculto;
                            }),
                          },
                      child: Text(
                        'Mostrar Senha',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    SizedBox(width: 90),
                    GestureDetector(
                      onTap:
                          () => {
                            Navigator.pushNamed(context, '/esqueceu-senha'),
                          },
                      child: Text(
                        'Esqueceu a senha?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.surface
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                BotaoEstilizadoWidget(
                  funcao: () => {Navigator.pushNamed(context, '/home')},
                  texto: 'Fazer Login',
                ),
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
                      onTap: () => {Navigator.pushNamed(context, '/registro')},
                      child: Text(
                        'Registre-se!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.surface,
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
