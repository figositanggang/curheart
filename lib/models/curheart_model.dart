import 'package:cloud_firestore/cloud_firestore.dart';

class CurheartModel {
  final String id;
  final String createdBy;
  final String type;
  final String title;
  final String isiCurheart;
  final int color;
  final Timestamp createdAt;

  CurheartModel({
    required this.id,
    required this.createdBy,
    required this.type,
    required this.title,
    required this.isiCurheart,
    required this.color,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "createdBy": this.createdBy,
      "type": this.type,
      "title": this.title,
      "color": this.color,
      "isiCurheart": this.isiCurheart,
      "createdAt": this.createdAt,
    };
  }

  factory CurheartModel.fromSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;

    return CurheartModel(
      id: json["id"],
      createdBy: json["createdBy"],
      type: json["type"],
      title: json["title"],
      color: json["color"],
      isiCurheart: json["isiCurheart"],
      createdAt: json["createdAt"],
    );
  }
}
