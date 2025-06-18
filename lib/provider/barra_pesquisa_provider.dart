import 'package:flutter/material.dart';
import 'dart:async';
import '../models/perfil_model.dart';
import '../services/perfil_service.dart';
import '../widgets/resultado_pesquisa_widget.dart';

class BarraPesquisaProvider extends ChangeNotifier {
  List<PerfilModel> _resultados = [];
  String _texto = '';
  bool _isLoading = false;
  Timer? _debounce;
  OverlayEntry? _overlayEntry;

  List<PerfilModel> get resultados => _resultados;
  String get texto => _texto;
  bool get isLoading => _isLoading;

  void onTextoAlterado(BuildContext context, String novoTexto) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _texto = novoTexto;
      _pesquisarPerfis(context);
    });
  }

  Future<void> _pesquisarPerfis(BuildContext context) async {
    removeOverlay();

    if (_texto.trim().isEmpty) {
      _resultados = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _resultados = await PerfilService.pesquisarPerfis(_texto);
      if (_texto.isNotEmpty && _resultados.isNotEmpty) {
        _showOverlay(context);
      }
    } catch (e) {
      print("Erro ao pesquisar perfis: $e");
      _resultados = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showOverlay(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => limparPesquisa(),
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5,
              width: size.width,
              child: ResultadosPesquisaOverlay(perfis: _resultados),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void limparPesquisa() {
    _texto = '';
    _resultados = [];
    _debounce?.cancel();
    removeOverlay();
    notifyListeners();
  }
}
