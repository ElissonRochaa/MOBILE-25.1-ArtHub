import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:flutter/material.dart';

class TelaPerfilUsuario extends StatelessWidget {
  const TelaPerfilUsuario({super.key});

  static const Color corSombra = Color.fromRGBO(10, 10, 10, 0.3);

  Widget numerosPerfil(BuildContext context){
    return Positioned(
        left: 130,
        top: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hannah Montana",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            Text(
                "@hannahmontana",
                style: TextStyle(
                    fontWeight: FontWeight.w600
                )
            ),
            Row(
              children: [
                Text(
                  "20 seguidores",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: [Shadow(
                          color: corSombra,
                          offset: Offset(0, 3),
                          blurRadius: 2
                      )]
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "22 seguindo",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: [Shadow(
                          color: corSombra,
                          offset: Offset(0, 3),
                          blurRadius: 2
                      )]
                  ),
                ),
              ],
            )
          ],
        )
    );
  }

  Widget informacoesPerfil(BuildContext context){
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                "assets/images/gato_horizontal.jpg",
                width: MediaQuery.sizeOf(context).width,
                height: 159,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 100,
                left: 15,
                child: Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/hannah.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(70),
                      boxShadow: [BoxShadow(
                        color: corSombra,
                        offset: Offset(0, 5),
                        blurRadius: 2.0,
                      )]
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 165,
                child: Row(
                  children: [
                    Transform.translate(
                      offset: Offset(10, 0),
                      child: IconButton(
                        onPressed: () {print("Botão de editar foi apertado");},
                        icon: Icon(Icons.edit_outlined),
                        style: ButtonStyle(
                            iconSize: WidgetStatePropertyAll(30)
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-5, 0),
                      child: IconButton(
                        onPressed: () {print("Botão de compartilhar foi apertado");},
                        icon: Icon(Icons.share_outlined),
                        style: ButtonStyle(
                            iconSize: WidgetStatePropertyAll(30)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              numerosPerfil(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 94,
            decoration: BoxDecoration(
              color: Color(0xFFFEFFB9),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(
                color: corSombra,
                offset: Offset(0, 4),
                blurRadius: 3
              ),]
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                  bottom: 10
              ),
              /*
              * É preciso verificar o limite de caractéres para ter certeza
              * do tipo de OVERFLOW e estilo que vai ser usado nesse texto.
              * */
              child: Text(
                "You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget formatadorDeImage(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            'assets/images/hannah.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: BarraPesquisaWidget()
      ),
      body: Column(
        children: [
          informacoesPerfil(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 12,
                top: 30
              ),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                physics: BouncingScrollPhysics(),
                children: [
                  formatadorDeImage(context),
                  formatadorDeImage(context),
                  formatadorDeImage(context),
                  formatadorDeImage(context),
                  formatadorDeImage(context),
                  formatadorDeImage(context),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
