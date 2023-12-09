import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/core/add_curheart.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/main.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> getuser;
  late Query<Map<String, dynamic>> getAllCurheart;

  final currentUser = supabase.auth.currentUser!;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    getData();
  }

  // ! Get current user and all curhearts
  Future<void> getData() async {
    getuser = FirebaseFirestoreHelper.getUser(currentUser.id);
    getAllCurheart = FirebaseFirestoreHelper.getAllCurheart();
  }

  // ! Refresh Screen
  Future<void> refresh() async {
    getData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getuser,
      builder: (context, snapshot) {
        // ? WAITING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FullScreenLoading();
        }

        final userModel = UserModel.fromSnapshot(snapshot.data!);
        // ? SUCCESS
        return Scaffold(
          drawer: Drawer(),
          drawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: MediaQuery.sizeOf(context).width - 100,

          // @ Refresher
          body: RefreshIndicator(
            onRefresh: refresh,
            child: NestedScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                // @ App Bar
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Curheart"),
                  floating: true,
                  snap: true,
                  actions: [
                    InkWell(
                      onTap: () {
                        try {
                          scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } catch (e) {}
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? darkPrimary
                                    : lightPrimary,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(userModel.photoUrl),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],

              // @ Body
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FirestoreListView(
                  shrinkWrap: true,
                  primary: false,
                  query: getAllCurheart,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, snapshot) {
                    return CureheartCard(
                      userModel: userModel,
                      curheartModel: CurheartModel.fromSnapshot(snapshot),
                    );
                  },
                  loadingBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  emptyBuilder: (context) => Center(
                    child: Text("Kosong"),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Tambah curheart",
            child: FaIcon(
              FontAwesomeIcons.pen,
              size: 15,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CustomRoute(AddCurheart(userModel: userModel)),
              );
            },
          ),
        );
      },
    );
  }
}
