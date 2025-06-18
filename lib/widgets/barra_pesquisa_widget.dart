import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/barra_pesquisa_provider.dart';

class BarraPesquisaWidget extends StatefulWidget {
  const BarraPesquisaWidget({super.key});

  @override
  State<BarraPesquisaWidget> createState() => _BarraPesquisaWidgetState();
}

class _BarraPesquisaWidgetState extends State<BarraPesquisaWidget> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && controller.text.isEmpty) {
        context.read<BarraPesquisaProvider>().limparPesquisa();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BarraPesquisaProvider>(
      builder: (context, provider, child) {
        if (provider.texto.isEmpty && controller.text.isNotEmpty) {
          controller.clear();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 31,
                child: SearchBar(
                  controller: controller,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    provider.onTextoAlterado(context, value);
                  },
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      provider.onTextoAlterado(context, controller.text);
                    }
                  },
                  hintText: 'Pesquisar...',
                  textStyle: MaterialStateProperty.all(
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ), // ...
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
