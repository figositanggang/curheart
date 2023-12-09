import 'package:flutter/material.dart';

class CurheartProvider extends ChangeNotifier {
  TextEditingController _isiCurheart = TextEditingController();
  TextEditingController get isiCurheart => this._isiCurheart;

  set setIsiCurheart(String value) {
    this._isiCurheart.text = value;
    notifyListeners();
  }

  double _fontSize = 18;
  double get fontSize => this._fontSize;

  addFontSize(double value) {
    this._fontSize += value;
    notifyListeners();
  }

  minFontSize(double value) {
    this._fontSize -= value;
    notifyListeners();
  }

  set fontSize(double value) {
    this._fontSize = value;
    notifyListeners();
  }
}
