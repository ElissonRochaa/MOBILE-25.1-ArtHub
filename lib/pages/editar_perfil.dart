import 'package:flutter/material.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';

class EditarPerfil extends StatelessWidget {
  const EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const BarraPesquisaWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Texto de editar perfil
            const Text('Editar Perfil', style: TextStyle(fontSize: 20)),

            const SizedBox(height: 12),

            // Foto de perfil com ícone de edição
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/hannah.jpg'),
                ),
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit, size: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Campos de input
            _campo(context, 'Nome'),
            _campo(context, 'Apelido'),
            _campo(context, 'Email'),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(child: _campoBannerEstatico()),
                  //const SizedBox(width: 20),
                  Expanded(child: _campo(context, 'Biografia')),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Botão salvar
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 6,
              ),
              child: const Text('Salvar alterações'),
            ),

            const SizedBox(height: 24),

            // Opções de conta (estáticas)
            _opcaoSimples('Desativar conta'),
            _opcaoSimples('Excluir conta'),
            _opcaoSimples('Sair'),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _campo(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoBannerEstatico() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Walt Disney Pictures',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: Icon(Icons.edit, size: 14),
          ),
        ),
      ],
    );
  }

  Widget _opcaoSimples(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(texto, style: const TextStyle(fontSize: 16)),
    );
  }
}