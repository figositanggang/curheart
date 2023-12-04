import 'package:curheart/auth/login_page.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/helper/supabase_auth_helper.dart';
import 'package:curheart/main.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/user_provider.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserProvider userProvider;
  final currentUser = supabase.auth.currentUser!;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<void> getData() async {
    if (userProvider.userModel == null) {
      await FirebaseFirestoreHelper.getUser(currentUser.id, userProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FullScreenLoading();
        }

        return Scaffold(
          drawer: Drawer(),
          drawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: MediaQuery.sizeOf(context).width - 100,
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 500));

              getData();
              setState(() {});
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
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
                            image:
                                NetworkImage(userProvider.userModel!.photoUrl),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                // @ List Curhatan untuk anda
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 10,
                      (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          // child:
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                SupabaseAuthHelper.signOut();

                Navigator.pushReplacement(context, CustomRoute(LoginPage()));
              } catch (e) {}
            },
          ),
        );
      },
    );
  }
}
