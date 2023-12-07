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
  static Future<void> getUser(String userId, UserProvider userProvider) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(userId).get();

      userProvider.setUserModel = UserModel.fromJson(snapshot);
    } catch (e) {}
  }
  //---------------------------------------------------------------------------

  //
  // FOR CURHEART
  //

  // ! Get All Curheart
  static Future<void> getAllCurheart(CurheartProvider curheartProvider) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("curhearts").get();

      for (var data in snapshot.docs) {
        CurheartModel curheartModel = CurheartModel.fromSnapshot(data);

        curheartProvider.addCurheart = curheartModel;
      }
    } on FirebaseException catch (e) {
      print("ERROR GETTING ALL CURHEARTS: $e");
    }
  }

  // ! Post a Curheart
  static Future postCurheart(CurheartModel curheartModel) async {
    try {
      DocumentReference reference =
          await _firestore.collection("curhearts").add(curheartModel.toMap());

      return "success";
    } catch (e) {
      return "error";
    }
  }
  //---------------------------------------------------------------------------
}
