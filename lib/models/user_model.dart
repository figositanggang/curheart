import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String photoUrl;
  final List curhearts;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.curhearts,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "photoUrl": this.photoUrl,
      "curhearts": this.curhearts,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      photoUrl: json["photoUrl"],
      curhearts: json["curhearts"],
    );
  }
}
