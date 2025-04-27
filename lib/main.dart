import 'package:flutter/material.dart';
import 'config/themeApp.dart';
import 'pages/tela_inicial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.theme,
      title: 'ArtHub',
      home: TelaInicial(),
    );
  }
}
