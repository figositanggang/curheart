import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';

class CureheartDetailScreen extends StatefulWidget {
  final CurheartModel curheartModel;

  const CureheartDetailScreen({super.key, required this.curheartModel});

  @override
  State<CureheartDetailScreen> createState() => _CureheartDetailScreenState();
}

class _CureheartDetailScreenState extends State<CureheartDetailScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> getUser;

  @override
  void initState() {
    super.initState();

    getUser = FirebaseFirestoreHelper.getUser(widget.curheartModel.createdBy);
  }

  @override
  Widget build(BuildContext context) {
    final curheartModel = widget.curheartModel;

    return FutureBuilder(
      future: getUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material();
        }

        final userModel = UserModel.fromSnapshot(snapshot.data!);
        return Material(
          color: Color(curheartModel.color),
          child: Scaffold(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
            appBar: MyAppBar(
              context,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  // @ User Profile Picture
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? darkPrimary
                            : lightPrimary,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(userModel.photoUrl),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  // @ User Name
                  Text(userModel.name),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // @ Title Curheart
                    Text(
                      curheartModel.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    // @ Isi Curheart
                    Text(curheartModel.isiCurheart),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
