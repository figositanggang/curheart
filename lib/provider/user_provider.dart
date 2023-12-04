import 'package:curheart/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => this._userModel;

  set setUserModel(UserModel? userModel) {
    this._userModel = userModel;
    notifyListeners();
  }
}
