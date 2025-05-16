import 'package:arthub/provider/barra_pesquisa_provider.dart';
import 'package:arthub/widgets/perfil_pesquisa_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarraPesquisaWidget extends StatefulWidget {
  const BarraPesquisaWidget({super.key});

  @override
  State<BarraPesquisaWidget> createState() => _BarraPesquisaWidgetState();
}

class _BarraPesquisaWidgetState extends State<BarraPesquisaWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarraPesquisaProvider>().setTexto(
        '',
      ); //Aqui limpa o texto da barra!
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 31,
          width: 246,
          child: SearchBar(
            controller: controller,
            onChanged:
                (value) =>
                    context.read<BarraPesquisaProvider>().setTexto(value),
            hintText: '',
            leading: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }
}
