import 'package:arthub/enums/categoria_enum.dart';
import 'package:arthub/models/publicacao_model.dart';
import 'package:arthub/services/publicacao_service.dart';
import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/input_texto.dart';
import 'package:flutter/material.dart';

class TelaEditarPublicacao extends StatefulWidget {
  final PublicacaoModel publicacao;

  const TelaEditarPublicacao({super.key, required this.publicacao});

  @override
  State<TelaEditarPublicacao> createState() => _TelaEditarPublicacaoState();
}

class _TelaEditarPublicacaoState extends State<TelaEditarPublicacao> {
  late TextEditingController _tituloController;
  late TextEditingController _legendaController;
  late CategoriaEnum _categoriaSelecionada;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.publicacao.titulo);
    _legendaController = TextEditingController(text: widget.publicacao.legenda);
    _categoriaSelecionada = widget.publicacao.categoria;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _legendaController.dispose();
    super.dispose();
  }

  Future<void> _salvarEdicao() async {
    setState(() => _loading = true);
    try {
      final editada = PublicacaoModel(
        id: widget.publicacao.id,
        tipoArquivo: widget.publicacao.tipoArquivo,
        legenda: _legendaController.text,
        nomeConteudo: widget.publicacao.nomeConteudo,
        titulo: _tituloController.text,
        categoria: _categoriaSelecionada,
        curtidas: widget.publicacao.curtidas,
        perfil: widget.publicacao.perfil,
        perfisQueCurtiram: widget.publicacao.perfisQueCurtiram,
      );
      await PublicacaoService.putPublicacao(editada);
      if (mounted) {
        Navigator.pop(context, editada);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _campoEditavel({
    required String label,
    required TextEditingController controller,
    required VoidCallback onEdit,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(labelText: label),
          ),
        ),
        IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Publicação')),
      body:
          _loading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    InputTexto(
                      label: 'Título',
                      hintLabel: 'Digite o título',
                      controller: _tituloController,
                    ),
                    SizedBox(height: 16),
                    InputTexto(
                      label: 'Legenda',
                      hintLabel: 'Digite a legenda',
                      controller: _legendaController,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<CategoriaEnum>(
                            value: _categoriaSelecionada,
                            decoration: InputDecoration(labelText: 'Categoria'),
                            items:
                                CategoriaEnum.values
                                    .map(
                                      (cat) => DropdownMenuItem(
                                        value: cat,
                                        child: Text(cat.name.toUpperCase()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (cat) {
                              if (cat != null)
                                setState(() => _categoriaSelecionada = cat);
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Selecione uma categoria'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    BotaoEstilizadoWidget(
                      funcao: _salvarEdicao,
                      texto: 'Salvar',
                    ),
                  ],
                ),
              ),
    );
  }

  Future<String?> _showDialogEditarCampo(
    BuildContext context,
    String titulo,
    String valorAtual,
  ) async {
    final controller = TextEditingController(text: valorAtual);
    return showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(titulo),
            content: TextField(controller: controller, autofocus: true),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context, controller.text),
              ),
            ],
          ),
    );
  }
}
