import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/barra_pesquisa_provider.dart';

class TelaCriarPublicacao extends StatelessWidget {
  const TelaCriarPublicacao({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Criar Publicação',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Em quais categorias essa publicação se encaixa?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 5),
              child: ListaFiltrosWidget(),
            ),
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width - 54,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1,
                      color: Color(0xFFCAC4D0)
                  )
              ),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Qual o título da publicação?',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              // esse container vai ser onde o arquivo do usuário vai ficar
              // TODO
              height: 347,
              width: 347,
              color: Colors.grey,
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width - 54,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(10, 10, 10, 0.3),
                    offset: Offset(4, 4),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'A publicação tem legenda?',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 25,),
            BotaoEstilizadoWidget(
              funcao: (){print('Publicação foi criada');},
              texto: 'Compartilhar Publicação',
            )
          ],
        ),
      ),
    );
  }
}
