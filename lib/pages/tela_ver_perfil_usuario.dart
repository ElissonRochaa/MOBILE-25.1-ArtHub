import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';

class TelaVerperfilUsuario extends StatefulWidget {
  const TelaVerperfilUsuario({super.key});

  @override
  State<TelaVerperfilUsuario> createState() => _TelaVerperfilUsuarioState();
}

class _TelaVerperfilUsuarioState extends State<TelaVerperfilUsuario> {
  static const Color corSombra = Color.fromRGBO(10, 10, 10, 0.3);
  bool seguindo = false;

  Widget numerosPerfil(BuildContext context) {
    return Positioned(
      left: 130,
      top: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hannah Montana",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text("@hannahmontana", style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Text(
                "20 seguidores",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: corSombra,
                      offset: Offset(0, 3),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Text(
                "22 seguindo",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: corSombra,
                      offset: Offset(0, 3),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget informacoesPerfil(BuildContext context) {
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
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(4),
                  ),
                ),
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
                    boxShadow: [
                      BoxShadow(
                        color: corSombra,
                        offset: Offset(0, 5),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
              numerosPerfil(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  seguindo = !seguindo;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    seguindo
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
              ),
              child: Text(
                seguindo ? 'Seguindo' : 'Seguir',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 94,
            decoration: BoxDecoration(
              color: Color(0xFFFEFFB9),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: corSombra,
                  offset: Offset(0, 4),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
                bottom: 10,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: BarraPesquisaWidget(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([informacoesPerfil(context)]),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 12,
              top: 30,
              bottom: 10,
            ),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                PublicacaoWidget(),
                PublicacaoWidget(),
                PublicacaoWidget(),
                PublicacaoWidget(),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
