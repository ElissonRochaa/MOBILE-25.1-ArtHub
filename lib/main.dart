import 'package:arthub/config/themeApp.dart';
import 'package:arthub/pages/tela_apresentacao.dart';
import 'package:arthub/pages/tela_logotipo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtHub',
      theme: ThemeApp.theme,
      home: const TelaApresentacao(),
    );
  }
}
