import 'package:arthub/pages/tela_inicial.dart';
import 'package:arthub/pages/tela_perfil_usuario.dart';
import 'package:arthub/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int selectedIndex = 0;

  final List<Widget> pages = [const TelaInicial(), const TelaPerfilUsuario()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavbarWidget(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
