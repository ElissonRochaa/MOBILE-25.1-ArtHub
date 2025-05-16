import 'package:arthub/config/themeApp.dart';
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
        color: Colors.white,
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
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    estaOculto
                        ? Icon(Icons.remove_red_eye_outlined)
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
                          color: Theme.of(context).colorScheme.onPrimary,
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
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => {Navigator.pushNamed(context, "/home")},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(165, 46),
                    backgroundColor: ThemeApp.theme.colorScheme.tertiary,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Fazer Login',
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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(width: 3),
                    GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, '/registro')},
                      child: Text(
                        'Registre-se!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
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
