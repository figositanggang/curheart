import 'package:curheart/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => this.userModel;

  set setUserModel(UserModel? userModel) {
    this.userModel = userModel;
    notifyListeners();
  }
}
