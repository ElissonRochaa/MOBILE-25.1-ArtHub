import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool _carregando = true;
  List<PublicacaoModel> _publicacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarPublicacoes();
  }

  Future<void> _carregarPublicacoes() async {
    setState(() {
      _carregando = true;
    });

    try {
      final publicacoes = await PublicacaoService.getAllPublicacao();
      setState(() {
        _publicacoes = publicacoes;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _carregando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocorreu um erro ao tentar carregar as publicações'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _carregarPublicacoes,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([ListaFiltrosWidget()]),
              ),
              if (_carregando)
                SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_publicacoes.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text('Nenhuma publicação foi encontrada'),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childCount: _publicacoes.length,
                    itemBuilder: (context, index) {
                      final PublicacaoModel publicacao = _publicacoes[index];
                      return PublicacaoWidget(publicacao: publicacao);
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
