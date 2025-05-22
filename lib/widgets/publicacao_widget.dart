import 'package:flutter/material.dart';

class PublicacaoWidget extends StatelessWidget {
  const PublicacaoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/publicacao');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cat.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(10, 10, 10, 0.3),
                  offset: Offset(0, 6),
                  blurRadius: 2.0,
                ),
              ],
            ),
            width: 150,
            height: 160,
          ),
          Text(
            '@esnupi',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
