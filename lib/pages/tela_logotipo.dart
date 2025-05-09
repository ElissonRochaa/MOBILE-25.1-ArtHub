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
    Future.delayed(const Duration(seconds: 3), () {
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
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo_arthub.png"),
              fit: BoxFit.fill,
            ),
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
