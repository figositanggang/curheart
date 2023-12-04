import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/user_provider.dart';

class FirebaseFirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ! Add New User
  static Future<void> addUser(UserModel userModel) async {
    _firestore.collection("users").doc(userModel.userId).set(userModel.toMap());
  }

  // ! Get a User
  static Future<void> getUser(String userId, UserProvider userProvider) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(userId).get();

      userProvider.userModel = UserModel.fromJson(snapshot);
    } catch (e) {}
  }
}
