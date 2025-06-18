import 'package:arthub/models/perfil_model.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/perfil_service.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PerfilPageData {
  final PerfilModel perfil;
  final List<int> contadores;
  final ImageProvider? avatarProvider;
  final ImageProvider? bannerProvider;
  final List<PublicacaoModel> publicacoes;

  PerfilPageData({
    required this.perfil,
    required this.contadores,
    this.avatarProvider,
    this.bannerProvider,
    required this.publicacoes,
  });
}

class TelaOutroPerfil extends StatefulWidget {
  const TelaOutroPerfil({super.key});

  @override
  State<TelaOutroPerfil> createState() => _TelaOutroPerfilState();
}

class _TelaOutroPerfilState extends State<TelaOutroPerfil> {
  late Future<PerfilPageData> _perfilPageFuture;
  late int _usuarioId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is int) {
      _usuarioId = args;
      _perfilPageFuture = _fetchPerfilData(_usuarioId);
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<PerfilPageData> _fetchPerfilData(int usuarioId) async {
    final results = await Future.wait([
      PerfilService.getPerfilByUsuarioId(usuarioId),
      PerfilService.getSeguidoresAndSeguindo(usuarioId),
      PerfilService.getImagePerfil(usuarioId),
      PerfilService.getImageBanner(usuarioId),
      PublicacaoService.getPublicacaoByUsuario(usuarioId),
    ]);

    return PerfilPageData(
      perfil: results[0] as PerfilModel,
      contadores: results[1] as List<int>,
      avatarProvider: results[2] as ImageProvider?,
      bannerProvider: results[3] as ImageProvider?,
      publicacoes: results[4] as List<PublicacaoModel>,
    );
  }

  Widget numerosPerfil(BuildContext context, PerfilPageData data) {
    return Positioned(
      left: 130,
      top: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.perfil.usuario.nome,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            '@${data.perfil.usuario.apelido}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            children: [
              Text('${data.contadores[0]} seguidores'),
              const SizedBox(width: 20),
              Text('${data.contadores[1]} seguindo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget informacoesPerfil(BuildContext context, PerfilPageData data) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image(
                image:
                    data.bannerProvider ??
                    const AssetImage('assets/images/banner_default.png'),
                width: MediaQuery.of(context).size.width,
                height: 159,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 100,
                left: 15,
                child: CircleAvatar(
                  radius: 52.5,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        data.avatarProvider ??
                        const AssetImage('assets/images/perfil_default.jpg'),
                  ),
                ),
              ),
              numerosPerfil(context, data),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              data.perfil.biografia ?? 'Nenhuma biografia disponível.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const BarraPesquisaWidget(),
      ),
      body: FutureBuilder<PerfilPageData>(
        future: _perfilPageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    informacoesPerfil(context, data),
                  ]),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(15),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childCount: data.publicacoes.length,
                    itemBuilder: (context, index) {
                      final pub = data.publicacoes[index];
                      return PublicacaoWidget(publicacao: pub);
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Perfil não encontrado.'));
        },
      ),
    );
  }
}
