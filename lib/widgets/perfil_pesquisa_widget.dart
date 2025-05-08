import 'package:arthub/widgets/tela_com_navbar.dart';
import 'package:flutter/material.dart';

class PerfilPesquisaWidget extends StatelessWidget {
  final String pesquisa;

  const PerfilPesquisaWidget({super.key, required this.pesquisa});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => TelaComNavbar(initialPage: 1)
          )
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 2
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFFFDA72),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [BoxShadow(
              color: Color.fromRGBO(10, 10, 10, 0.3),
              offset: Offset(5, 5),
              blurRadius: 2.0
            )],
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
                      Text('10M seguidores', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
