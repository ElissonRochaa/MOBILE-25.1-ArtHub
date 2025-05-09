import 'package:flutter/material.dart';
import 'package:arthub/pages/tela_apresentacao.dart';

class TelaLogotipo extends StatefulWidget {
  const TelaLogotipo({super.key});

  @override
  State<TelaLogotipo> createState() => _TelaLogotipoState();
}

class _TelaLogotipoState extends State<TelaLogotipo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(
        context,
      ).pushReplacement(_fadeRoute(const TelaApresentacao()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Text(
          "A logotipo vai aqui", // Adicionar a logo aqui depois!
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 750),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut, //
        );

        return FadeTransition(opacity: curvedAnimation, child: child);
      },
    );
  }
}
