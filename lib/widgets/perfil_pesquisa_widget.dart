import 'package:flutter/material.dart';

class PerfilPesquisaWidget extends StatelessWidget {
  const PerfilPesquisaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          width: 332,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/snoopy.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Snoopy chill guy',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text('@esnupi', style: TextStyle(fontSize: 14)),
                      SizedBox(width: 10),
                      Text('10 M seguidores', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
