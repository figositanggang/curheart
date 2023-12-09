import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/curheart_provider.dart';
import 'package:curheart/provider/user_provider.dart';

class FirebaseFirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  // FOR USER
  //

  // ! Add New User
  static Future<void> addUser(UserModel userModel) async {
    _firestore.collection("users").doc(userModel.id).set(userModel.toMap());
  }

  // ! Get a User
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
      String userId) async {
    return _firestore.collection("users").doc(userId).get();
  }
  //---------------------------------------------------------------------------

  //
  // FOR CURHEART
  //

  // ! Get All Curheart
  static Query<Map<String, dynamic>> getAllCurheart() {
    return _firestore
        .collection("curhearts")
        .orderBy("createdAt", descending: true);
  }

  // ! Post a Curheart
  static Future postCurheart(CurheartModel curheartModel) async {
    try {
      DocumentReference reference =
          await _firestore.collection("curhearts").add(curheartModel.toMap());

      await _firestore
          .collection("curhearts")
          .doc(reference.id)
          .update({"id": reference.id});
      return "success";
    } catch (e) {
      return "error";
    }
  }
  //---------------------------------------------------------------------------
}
