import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "photoUrl": this.photoUrl,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      photoUrl: json["photoUrl"],
    );
  }
}
