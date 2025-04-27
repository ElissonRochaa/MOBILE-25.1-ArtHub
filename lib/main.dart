import 'package:arthub/config/themeApp.dart';
import 'package:arthub/pages/post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtHub',
      theme: ThemeApp.theme,
      home: PostScreen(),
    );
  }
}
