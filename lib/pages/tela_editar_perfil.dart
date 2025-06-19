import 'dart:io';
import 'dart:typed_data';

import 'package:arthub/services/token_service.dart';
import 'package:universal_io/io.dart' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:arthub/models/dtos/perfil_editado_DTO.dart';
import 'package:arthub/provider/modo_tema_provider.dart';
import 'package:arthub/services/perfil_service.dart';
import 'package:arthub/services/usuario_service.dart';
import 'package:arthub/widgets/rodape_widget.dart';
import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/stackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaEditarPerfil extends StatefulWidget {
  const TelaEditarPerfil({super.key});

  @override
  State<TelaEditarPerfil> createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  final TextEditingController _apelidoController = TextEditingController();
  final TextEditingController _biografiaController = TextEditingController();
  late int _usuarioId;

  File? _novaFotoPerfil;
  Uint8List? _novaFotoPerfilWeb;
  File? _novoBanner;
  Uint8List? _novoBannerWeb;

  ImageProvider? _fotoPerfilProvider;
  ImageProvider? _bannerProvider;

  @override
  void initState() {
    super.initState();
    _carregarImagensIniciais();
    _getUsuarioId();
  }

  Future<void> _getUsuarioId() async {
    _usuarioId = (await UsuarioService.getUsuarioId())!;
  }

  Future<void> _carregarImagensIniciais() async {
    final usuarioId = await UsuarioService.getUsuarioId();
    final fotoPerfil = await PerfilService.getImagePerfil(
      usuarioId!,
    ).catchError((_) => null);
    final bannerPerfil = await PerfilService.getImageBanner(
      usuarioId,
    ).catchError((_) => null);

    setState(() {
      _fotoPerfilProvider =
          fotoPerfil ?? const AssetImage('assets/images/perfil_default.jpg');
      _bannerProvider =
          bannerPerfil ?? const AssetImage('assets/images/banner_default.png');
    });
  }

  @override
  void dispose() {
    _apelidoController.dispose();
    _biografiaController.dispose();
    super.dispose();
  }

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<void> _selecionarFotoPerfil() async {
    try {
      FilePickerResult? arquivoEscolhido = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (arquivoEscolhido != null) {
        setState(() {
          if (isMobile) {
            _novaFotoPerfil = File(arquivoEscolhido.files.single.path!);
            _fotoPerfilProvider = FileImage(_novaFotoPerfil!);
          } else {
            _novaFotoPerfilWeb = arquivoEscolhido.files.single.bytes;
            _fotoPerfilProvider = MemoryImage(_novaFotoPerfilWeb!);
          }
        });
      }
    } catch (e) {
      throw Exception('Erro ao selecionar foto de perfil');
    }
  }

  Future<void> _selecionarBanner() async {
    try {
      FilePickerResult? arquivoEscolhido = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (arquivoEscolhido != null) {
        setState(() {
          if (isMobile) {
            _novoBanner = File(arquivoEscolhido.files.single.path!);
            _bannerProvider = FileImage(_novoBanner!);
          } else {
            _novoBannerWeb = arquivoEscolhido.files.single.bytes;
            _bannerProvider = MemoryImage(_novoBannerWeb!);
          }
        });
      }
    } catch (e) {
      throw Exception('Erro ao selecionar banner');
    }
  }

  Future<void> _enviarAlteracoes() async {
    final usuario = await UsuarioService.getUsuarioById(_usuarioId);
    final perfil = await PerfilService.getPerfilByUsuarioId(_usuarioId);

    final perfilEditado = PerfilEditadoDTO(
      apelido:
          _apelidoController.text.isNotEmpty
              ? '@${_apelidoController.text.trim().replaceAll(' ', '')}'
              : usuario.apelido,
      biografia:
          _biografiaController.text.isNotEmpty
              ? _biografiaController.text
              : perfil.biografia!,
    );

    await PerfilService.putPerfil(perfilEditado, _usuarioId);

    if (_novaFotoPerfil != null || _novaFotoPerfilWeb != null) {
      await PerfilService.uploadImagem(
        perfil.id,
        _novaFotoPerfil,
        _novaFotoPerfilWeb,
        true,
      );
    }
    if (_novoBanner != null || _novoBannerWeb != null) {
      await PerfilService.uploadImagem(
        perfil.id,
        _novoBanner,
        _novoBannerWeb,
        false,
      );
    }

    Navigator.pop(context);
    showCustomSnackBar(context, 'Alterações realizadas com sucesso');
  }

  Widget _campo(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
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

  void _mostrarPopup(BuildContext context, String titulo) {
    String mensagem = '';
    Color corTitulo = Theme.of(context).colorScheme.primary;
    String pergunta = '';

    switch (titulo) {
      case 'Desativar conta':
        mensagem = 'Tem certeza que deseja desativar sua conta?';
        pergunta = 'Desativar conta?';
        break;
      case 'Excluir conta':
        mensagem =
            'Tem certeza que deseja excluir sua conta? Esta ação não poderá ser desfeita.';
        pergunta = 'Excluir conta?';
        break;
      case 'Sair':
        mensagem = 'Tem certeza que deseja sair do aplicativo?';
        pergunta = 'Sair do aplicativo?';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: corTitulo,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Text(
                  pergunta,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          174,
                          237,
                          177,
                        ),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (titulo == 'Desativar conta'){
                          print('O botão de desativar conta foi clicado');
                        } else if (titulo == 'Excluir conta'){
                          UsuarioService.deleteUsuario(_usuarioId);
                          Navigator.popUntil(context, (route) => route.settings.name == '/login');
                          showCustomSnackBar(context, 'Conta excluída com sucesso');
                        } else {
                          TokenService.removeToken();
                          Navigator.popUntil(context, (route) => route.settings.name == '/login');
                          showCustomSnackBar(context, 'Você saiu da conta com sucesso');
                        }
                      },
                      child: const Text('Sim'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          246,
                          158,
                          158,
                        ),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Não'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeAppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
              tooltip: 'Trocar tema',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'Editar Perfil',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 12),
            // Foto de perfil (preview imediato)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      _fotoPerfilProvider ??
                      const AssetImage('assets/images/perfil_default.jpg'),
                ),
                InkWell(
                  onTap: _selecionarFotoPerfil,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _campo(context, 'Apelido', _apelidoController),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        Text(
                          'Banner',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
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
                                image: DecorationImage(
                                  image:
                                      _bannerProvider ??
                                      const AssetImage(
                                        'assets/images/banner_default.png',
                                      ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _selecionarBanner,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
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
                          Text(
                            'Biografia',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          TextFormField(
                            controller: _biografiaController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              contentPadding: const EdgeInsets.all(12),
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
            BotaoEstilizadoWidget(
              funcao: () => {_enviarAlteracoes()},
              texto: 'Salvar alterações',
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
          ],
        ),
      ),
      bottomNavigationBar: RodapeWidget(),
    );
  }
}
