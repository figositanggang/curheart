import 'package:flutter/material.dart';

class CurheartProvider extends ChangeNotifier {
  TextEditingController _isiCurheart = TextEditingController();
  TextEditingController get isiCurheart => this._isiCurheart;

  set setIsiCurheart(String value) {
    this._isiCurheart.text = value;
    notifyListeners();
  }
}
