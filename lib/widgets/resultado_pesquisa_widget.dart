import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/perfil_model.dart';
import '../provider/barra_pesquisa_provider.dart';
import 'perfil_pesquisa_widget.dart';

class ResultadosPesquisaOverlay extends StatelessWidget {
  final List<PerfilModel> perfis;

  const ResultadosPesquisaOverlay({super.key, required this.perfis});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(15),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          shrinkWrap: true,
          itemCount: perfis.length,
          itemBuilder: (context, index) {
            final perfil = perfis[index];
            return GestureDetector(
              onTap: () {
                context.read<BarraPesquisaProvider>().limparPesquisa();
                Navigator.pushNamed(
                  context,
                  '/outro-perfil',
                  arguments: perfil.usuario.id,
                );
              },
              child: PerfilPesquisaWidget(perfil: perfil),
            );
          },
        ),
      ),
    );
  }
}
