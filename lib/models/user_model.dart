import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;
  final String photoUrl;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": this.userId,
      "email": this.email,
      "name": this.name,
      "photoUrl": this.photoUrl,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      userId: json["userId"],
      email: json["email"],
      name: json["name"],
      photoUrl: json["photoUrl"],
    );
  }
}
