import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TelaProprioPerfil extends StatefulWidget {
  const TelaProprioPerfil({super.key});

  static const Color corSombra = Color.fromRGBO(10, 10, 10, 0.3);

  @override
  State<TelaProprioPerfil> createState() => _TelaProprioPerfilState();
}

class _TelaProprioPerfilState extends State<TelaProprioPerfil> {
  bool lerTudo = false;
  // PerfilModel? perfil;

  // @override
  // void initState() {
  //   super.initState();
  //   buscarPerfil();
  // }

  // Future<void> buscarPerfil() async {
  //   try {
  //     final perfilCarregado = PerfilService().getUsuario();
  //     setState(() {
  //       perfil = perfilCarregado;
  //     });
  //   } catch (e) {
  //     showCustomSnackBar(context, "Erro ao buscar perfil: $e");
  //   }
  // }

  final List<String> imagens = [
    'assets/images/teste1.jpeg',
    'assets/images/teste2.jpeg',
    'assets/images/cat.jpeg',
    'assets/images/hannah.jpg',
    'assets/images/snoopy.jpeg',
  ];

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
                  color: Theme.of(context).colorScheme.onPrimary,
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
                  color: Theme.of(context).colorScheme.onPrimary,
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
            onTap: () {
              setState(() {
                lerTudo = !lerTudo;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: lerTudo ? null : 94,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
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
                child:
                    lerTudo
                        ? Text(
                          "You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                        : Text(
                          "You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3You get the best of both words <3",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
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
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childCount: 5,
              itemBuilder: (context, index) {
                final imagePath = imagens[index % imagens.length];

                return PublicacaoWidget(imagePath: imagePath);
              },
            ),
          ),
        ),
      ],
    );
  }
}
