import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/curheart_provider.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CureheartDetailScreen extends StatefulWidget {
  final CurheartModel curheartModel;

  const CureheartDetailScreen({super.key, required this.curheartModel});

  @override
  State<CureheartDetailScreen> createState() => _CureheartDetailScreenState();
}

class _CureheartDetailScreenState extends State<CureheartDetailScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> getUser;
  late CurheartProvider curheartProvider;

  @override
  void initState() {
    super.initState();

    getUser = FirebaseFirestoreHelper.getUser(widget.curheartModel.createdBy);
    curheartProvider = Provider.of<CurheartProvider>(context, listen: false);
  }

  @override
  void dispose() {
    curheartProvider.fontSize = 18;
    super.dispose();
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
                    Text(
                      curheartModel.isiCurheart,
                      style: TextStyle(
                        fontSize: context.watch<CurheartProvider>().fontSize,
                        fontFamily: GoogleFonts.openSans().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // @ Zoom Out Fonts
                IconButton(
                  onPressed: () {
                    if (curheartProvider.fontSize > 10) {
                      curheartProvider.minFontSize(1);
                    }
                  },
                  icon: FaIcon(FontAwesomeIcons.minus),
                ),

                // @ Zoom In Fonts
                IconButton(
                  onPressed: () {
                    if (curheartProvider.fontSize < 100) {
                      curheartProvider.addFontSize(1);
                    }
                  },
                  icon: FaIcon(FontAwesomeIcons.plus),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
