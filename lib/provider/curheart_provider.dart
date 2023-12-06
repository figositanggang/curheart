import 'package:curheart/models/curheart_model.dart';
import 'package:flutter/material.dart';

class CurheartProvider extends ChangeNotifier {
  List<CurheartModel> _allCurheart = [];
  List<CurheartModel> get allCurheart => this._allCurheart;

  set addCurheart(CurheartModel value) {
    this._allCurheart.add(value);
    notifyListeners();
  }

  set setCurheart(List<CurheartModel> value) {
    this._allCurheart = value;
    notifyListeners();
  }

  TextEditingController _isiCurheart = TextEditingController();
  TextEditingController get isiCurheart => this._isiCurheart;

  set setIsiCurheart(String value) {
    this._isiCurheart.text = value;
    notifyListeners();
  }
}
