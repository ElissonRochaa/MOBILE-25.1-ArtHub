import 'package:flutter/widgets.dart';

class BarraPesquisaProvider extends ChangeNotifier {
  String texto = '';

  void setTexto(String texto) {
    this.texto = texto;
    notifyListeners();
  }
}
