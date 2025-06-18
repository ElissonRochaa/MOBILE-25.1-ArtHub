import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      if (!_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          context.read<BarraPesquisaProvider>().removeOverlay();
        });
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.clear();
          });
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 31,
                child: SearchBar(
                  controller: controller,
                  focusNode: _focusNode,
                  hintText: '',
                  onChanged: (value) {
                    provider.onTextoAlterado(context, value);
                  },
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      provider.onTextoAlterado(context, controller.text);
                    }
                  },
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface,
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 10),
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Align(
              child: Image.asset(
                'assets/images/logo_arthub.png',
                color: Theme.of(context).colorScheme.onPrimary,
                height: 120,
              ),
            ),
          ],
        );
      },
    );
  }
}
