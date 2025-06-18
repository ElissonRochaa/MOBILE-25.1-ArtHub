import 'package:flutter/material.dart';
import 'dart:async';
import '../models/perfil_model.dart';
import '../services/perfil_service.dart';
import '../widgets/resultado_pesquisa_widget.dart';

class BarraPesquisaProvider extends ChangeNotifier {
  final PerfilService _perfilService = PerfilService();

  List<PerfilModel> _resultados = [];

  List<PerfilModel> get resultados => _resultados;

  void setResultados(List<PerfilModel> novosResultados) {
    _resultados = novosResultados;
    notifyListeners();
  }

  void clearResultados() {
    _resultados = [];
    notifyListeners();
  }

  String _texto = '';
  List<PerfilModel> _perfisEncontrados = [];
  bool _isLoading = false;
  Timer? _debounce;

  OverlayEntry? _overlayEntry;

  String get texto => _texto;
  List<PerfilModel> get perfisEncontrados => _perfisEncontrados;
  bool get isLoading => _isLoading;

  void onTextoAlterado(BuildContext context, String novoTexto) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _texto = novoTexto;
      _pesquisarPerfis(context);
    });
  }

  Future<void> _pesquisarPerfis(BuildContext context) async {
    removeOverlay();

    if (_texto.trim().isEmpty) {
      _perfisEncontrados = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _perfisEncontrados = await PerfilService.pesquisarPerfis(_texto);
      if (_perfisEncontrados.isNotEmpty) {
        _showOverlay(context);
      }
    } catch (e) {
      _perfisEncontrados = [];
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
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          width: size.width,
          child: ResultadosPesquisaOverlay(perfis: _perfisEncontrados),
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
    _perfisEncontrados = [];
    _debounce?.cancel();
    removeOverlay();
    notifyListeners();
  }
}
