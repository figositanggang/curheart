import 'package:cloud_firestore/cloud_firestore.dart';

class CurheartModel {
  final String id;
  final String createdBy;
  final String title;
  final int color;
  final List<String> curheart;
  final Timestamp createdAt;

  CurheartModel({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.curheart,
    required this.color,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "createdBy": this.createdBy,
      "title": this.title,
      "color": this.color,
      "curheart": this.curheart,
      "createdAt": this.createdAt,
    };
  }

  factory CurheartModel.fromSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;

    return CurheartModel(
      id: json["id"],
      createdBy: json["createdBy"],
      title: json["title"],
      color: json["color"],
      curheart: json["curheart"],
      createdAt: json["createdAt"],
    );
  }
}
