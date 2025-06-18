import 'package:arthub/models/perfil_model.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/perfil_service.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/services/usuario_service.dart';
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
  bool _lerTudo = false;
  bool _carregando = true;
  List<PublicacaoModel> _publicacoesDoUsuario = [];
  List<int> _seguidoresESeguindo = [];
  PerfilModel? _perfilUsuario;
  ImageProvider? _imagemPerfil;
  ImageProvider? _imagemBanner;

  @override
  void initState() {
    super.initState();
    _carregarDadosPerfil();
  }

  Future<void> _carregarDadosPerfil() async {
    if (!mounted) return;

    setState(() {
      _carregando = true;
    });

    try{
      final usuarioId = await UsuarioService.getUsuarioId() as int;
      final perfilUsuario = await PerfilService.getPerfilByUsuarioId(usuarioId);

      final results = await Future.wait([
        PerfilService.getPerfilByUsuarioId(usuarioId),
        PublicacaoService.getPublicacaoByUsuario(usuarioId),
        PerfilService.getImagePerfil(perfilUsuario.id).catchError((_) => null),
        PerfilService.getImageBanner(perfilUsuario.id).catchError((_) => null),
        PerfilService.getSeguidoresAndSeguindo(usuarioId),
      ]);

      if (!mounted) return;

      setState(() {
        _perfilUsuario = results[0] as PerfilModel;
        _publicacoesDoUsuario = results[1] as List<PublicacaoModel>;
        _imagemPerfil = results[2] as ImageProvider?;
        _imagemBanner = results[3] as ImageProvider?;
        _seguidoresESeguindo = results[4] as List<int>;
        _carregando = false;
      });

    } catch (e){
      print(e);
      setState(() {_carregando = false;});
    }
  }

  Widget _numerosPerfil(BuildContext context) {
    final perfil = _perfilUsuario!;

    return Positioned(
      left: 130,
      top: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            perfil.usuario.nome,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            perfil.usuario.apelido,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            children: [
              Text(
                "${_seguidoresESeguindo[0]} seguidores",
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
                "${_seguidoresESeguindo[1]} seguindo",
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

  Widget _informacoesPerfil(BuildContext context) {
    final perfil = _perfilUsuario!;

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 159,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _imagemBanner ?? AssetImage('assets/images/banner_default.png'),
                    fit: BoxFit.cover,
                  )
                ),
              )),
              Positioned(
                top: 100,
                left: 15,
                child: Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagemPerfil ?? AssetImage('assets/images/perfil_default.jpg'),
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
                        onPressed: () async {
                          await Navigator.pushNamed(context, "/editar-perfil");
                          _carregarDadosPerfil();
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
              _numerosPerfil(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _lerTudo = !_lerTudo;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: _lerTudo ? null : 40,
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
                    _lerTudo
                        ? Text(
                          perfil.biografia ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                        : Text(
                          perfil.biografia ?? '',
                          maxLines: 1,
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
        if (_perfilUsuario != null)
          SliverList(
            delegate: SliverChildListDelegate([_informacoesPerfil(context)]),
          ),
        if(_carregando)
          SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (_perfilUsuario == null)
          SliverFillRemaining(
            child: Center(child: Text('Erro ao carregar o perfil'),),
          )
        else if (_publicacoesDoUsuario.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text('O usuário não tem publicações ainda'),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(left: 15, right: 12, top: 30, bottom: 10,),
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childCount: _publicacoesDoUsuario.length,
                itemBuilder: (context, index) {
                  final PublicacaoModel publicacao = _publicacoesDoUsuario[index];
                  return PublicacaoWidget(publicacao: publicacao,);
                },
              ),
            ),
          ),
      ],
    );
  }
}
