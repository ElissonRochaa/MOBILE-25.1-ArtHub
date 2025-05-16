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
          width:
              MediaQuery.of(context).size.width * 0.9, // Atualizar com padding!
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        // Vamos rever a baixo se é realmente necessário...?

        // Container(
        //   height: 30,
        //   width: 30,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/hannah.jpg'),
        //       fit: BoxFit.cover,
        //     ),
        //     border: Border.all(color: Colors.white, width: 0.9),
        //     borderRadius: BorderRadius.circular(70),
        //   ),
        // ),
      ],
    );
  }
}
