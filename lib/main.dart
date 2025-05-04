import 'package:arthub/config/themeApp.dart';
import 'package:arthub/pages/tela_apresentacao.dart';
import 'package:arthub/pages/tela_esqueceu_senha.dart';
import 'package:arthub/pages/tela_inicial.dart';
import 'package:arthub/pages/tela_login.dart';
import 'package:arthub/pages/tela_logotipo.dart';
import 'package:arthub/pages/tela_perfil_usuario.dart';
import 'package:arthub/pages/tela_publicacao.dart';
import 'package:arthub/pages/tela_registro.dart';
import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/pages/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarraPesquisaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtHub',
      theme: ThemeApp.theme,
      home: TelaApresentacao(),
      initialRoute: '/',
      routes: {
        // '/': (context) => const TelaLogotipo(),
        '/registro': (context) => const TelaRegistro(),
        '/publicacao': (context) => const TelaPublicacao(),
        '/esqueceu-senha': (context) => const TelaEsqueceuSenha(),
        '/login': (context) => const TelaLogin(),
        '/home': (context) => const TelaInicial(),
        '/perfil': (context) => const TelaPerfilUsuario(),
      },
    );
  }
}
