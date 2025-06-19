import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/widgets/publicacao_widget.dart';
import 'package:arthub/widgets/stackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool _carregando = true;
  String? _filtroAtual;

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

  Future<void> _carregarPublicacacoesComFiltro(String categoria) async {
    setState(() {
      _carregando = true;
    });

    try{
      final publicacoes = await PublicacaoService.getPublicacaoByCategoria(categoria);
      setState(() {
        _carregando = false;
        _publicacoes = publicacoes;
      });
    }catch (e) {
      setState(() {
        _carregando = false;
      });
      showCustomSnackBar(context, 'Erro ao carregar as publicaçoes com o filtro $categoria');
    }
  }

  Widget _itemFiltro(String nome, bool isSelected, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 35,
        margin: EdgeInsets.only(right: 4),
        padding: EdgeInsets.only(left: 3, right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
          isSelected
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.onError,
          border: Border.all(
            color:
            isSelected
                ? Theme.of(context).colorScheme.tertiary
                : Color(0xFFCAC4D0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (isSelected)
              Icon(
                Icons.check,
                size: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            SizedBox(width: 4),
            Center(
              child: Text(
                nome,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCategoria(String filtro){
    switch (filtro) {
      case 'Poema':
        return 'POEMA';
      case 'Música':
        return 'MUSICA';
      case 'Pintura':
        return 'PINTURA';
      case 'Desenho':
        return 'DESENHO';
      case 'Escultura':
        return 'ESCULTURA';
      case 'Fotografia':
        return 'FOTOGRAFIA';
      default:
        throw Exception("Algo deu errado no toCategoriaEnum");
    }
  }

  Widget _listaDeFiltros() {
    ScrollController scrollController = ScrollController();
    final List<String> filtros = ["Poema", "Pintura", "Música", "Desenho", "Escultura", "Fotografia"];

    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbVisibility: WidgetStatePropertyAll(false),
        radius: Radius.circular(20),
        thickness: WidgetStatePropertyAll(5),
        thumbColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
        mainAxisMargin: 8,
      ),
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12, top: 10),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 8, right: 5),
            child: Row(
              children: filtros.map((filtro) {
                return Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: _itemFiltro(filtro, _filtroAtual == filtro, () {
                    setState(() {
                      if (_filtroAtual == filtro){
                        _filtroAtual = null;
                        _carregarPublicacoes();
                      } else {
                        _filtroAtual = filtro;
                        _carregarPublicacacoesComFiltro(getCategoria(filtro));
                      }
                    });
                  })
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
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
                delegate: SliverChildListDelegate([_listaDeFiltros()]),
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
