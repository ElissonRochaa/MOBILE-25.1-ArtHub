import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/pages/tela_editar_perfil.dart';
import 'package:arthub/pages/tela_editar_publicacao.dart';
import 'package:arthub/pages/tela_esqueceu_senha.dart';
import 'package:arthub/pages/tela_login.dart';
import 'package:arthub/pages/tela_logotipo.dart';
import 'package:arthub/pages/tela_proprio_perfil.dart';
import 'package:arthub/pages/tela_publicacao.dart';
import 'package:arthub/pages/tela_registro.dart';
import 'package:arthub/pages/tela_outro_perfil.dart';
import 'package:arthub/pages/tela_resetar_senha.dart';
import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/provider/modo_tema_provider.dart';
import 'package:arthub/widgets/tela_com_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarraPesquisaProvider()),
        ChangeNotifierProvider(create: (_) => ThemeAppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeAppProvider>(
      builder: (context, ThemeAppProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ArtHub',
          theme: ThemeAppProvider.themeData,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            final uri = Uri.parse(settings.name ?? '/');

            print(
              '🔍 Rota solicitada: ${uri.path}',
            ); // Agora mostra só o caminho, sem query

            switch (uri.path) {
              case '/':
                return buildPageRoute(const TelaLogotipo(), settings);
              case '/registro':
                return buildPageRoute(const TelaRegistro(), settings);
              case '/publicacao':
                final args = settings.arguments;
                if (args != null && args is PublicacaoModel) {
                  return buildPageRoute(
                    TelaPublicacao(publicacao: args),
                    settings,
                  );
                }
                break;
              case '/esqueceu-senha':
                return buildPageRoute(const TelaEsqueceuSenha(), settings);
              case '/resetar-senha':
                return buildPageRoute(const TelaResetarSenha(), settings);
              case '/login':
                return buildPageRoute(const TelaLogin(), settings);
              case '/home':
                return buildPageRoute(const TelaComNavbar(), settings);
              case '/perfil':
                return buildPageRoute(const TelaProprioPerfil(), settings);
              case '/editar-perfil':
                return buildPageRoute(const TelaEditarPerfil(), settings);
              case '/outro-perfil':
                return buildPageRoute(const TelaOutroPerfil(), settings);
              case '/tela_editar_publicacao':
                final args = settings.arguments;
                if (args != null && args is PublicacaoModel) {
                  return buildPageRoute(
                    TelaEditarPublicacao(publicacao: args),
                    settings,
                  );
                }
                break;
            }

            // Se nada foi encontrado, redireciona para uma tela padrão (ex: logotipo)
            return buildPageRoute(const TelaLogotipo(), settings);
          },
        );
      },
    );
  }
}

PageRouteBuilder buildPageRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 650),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      if (settings.name == '/login' || settings.name == '/registro') {
        begin = const Offset(0.0, 1.0);
      } else {
        begin = const Offset(1.0, 0.0);
      }

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
