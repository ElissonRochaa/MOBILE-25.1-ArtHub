import 'package:flutter/material.dart';

class PublicacaoWidget extends StatelessWidget {
  const PublicacaoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cat.jpeg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 150,
      height: 160,
    );
  }
}
