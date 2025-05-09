import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';

class TelaProprioPerfil extends StatefulWidget {
  const TelaProprioPerfil({super.key});

  static const Color corSombra = Color.fromRGBO(10, 10, 10, 0.3);

  @override
  State<TelaProprioPerfil> createState() => _TelaProprioPerfilState();
}

class _TelaProprioPerfilState extends State<TelaProprioPerfil> {
  bool lerTudo = false;

  Widget numerosPerfil(BuildContext context) {
    return Positioned(
      left: 130,
      top: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hannah Montana",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            "@hannahmontana",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            children: [
              Text(
                "20 seguidores",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'SignikaNegative',
                  shadows: [
                    Shadow(
                      color: TelaProprioPerfil.corSombra,
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
                  fontSize: 14,
                  fontFamily: 'SignikaNegative',
                  shadows: [
                    Shadow(
                      color: TelaProprioPerfil.corSombra,
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
                        color: TelaProprioPerfil.corSombra,
                        offset: Offset(0, 5),
                        blurRadius: 2.0,
                      ),
                    ],
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
                        onPressed: () {
                          Navigator.pushNamed(context, "/editar-perfil");
                        },
                        icon: Icon(Icons.edit_outlined),
                        style: ButtonStyle(
                          iconSize: WidgetStatePropertyAll(30),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-5, 0),
                      child: IconButton(
                        onPressed: () {
                          print("Botão de compartilhar foi apertado");
                        },
                        icon: Icon(Icons.share_outlined),
                        style: ButtonStyle(
                          iconSize: WidgetStatePropertyAll(30),
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: GestureDetector(
            onTap: (){
              setState(() {
                lerTudo = !lerTudo;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: lerTudo ? null : 94,
              decoration: BoxDecoration(
                color: Color(0xFFFEFFB9),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: TelaProprioPerfil.corSombra,
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
                child: lerTudo ? Text(
                  "You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3",
                  style: Theme.of(context).textTheme.bodyMedium,
                ) : Text(
                  "You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }
}
