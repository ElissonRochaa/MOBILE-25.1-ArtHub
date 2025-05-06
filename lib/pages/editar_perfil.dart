import 'package:flutter/material.dart';
import 'package:arthub/widgets/barra_pesquisa_widget.dart';

class EditarPerfil extends StatelessWidget {
  const EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.primary),
      
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
                InkWell(
                  onTap: () {
                    _mostrarPopup(context, 'Editar Foto de Perfil');
                  },
                  customBorder: const CircleBorder(),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Campos de input
            _campo(context, 'Nome'),
            _campo(context, 'Apelido'),
            _campo(context, 'Email'),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔵 Container do Banner com fundo colorido
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(1, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Banner',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 3),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/banner.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _mostrarPopup(context, 'Editar Banner');
                              },
                              customBorder: const CircleBorder(),
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.edit, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 🟢 Container da Biografia com fundo colorido
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(1, 4),
                          blurRadius: 4,
                        ),
                      ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Biografia',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 3),
                          TextFormField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                elevation: 8,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Salvar alterações'),
            ),

            const SizedBox(height: 24),

            _opcaoSimples(
              context,
              'Desativar conta',
              () => _mostrarPopup(context, 'Desativar conta'),
            ),
            _opcaoSimples(
              context,
              'Excluir conta',
              () => _mostrarPopup(context, 'Excluir conta'),
            ),
            _opcaoSimples(
              context,
              'Sair',
              () => _mostrarPopup(context, 'Sair'),
            ),

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
            labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _opcaoSimples(BuildContext context, String texto, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 28),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: onTap,
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarPopup(BuildContext context, String titulo) {}
}
