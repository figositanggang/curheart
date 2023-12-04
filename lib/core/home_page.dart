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
                  title: Text(
                    "Selamat Pagi, \n${userProvider.userModel!.name.split(" ")[0]}",
                    style: TextStyle(fontSize: 30),
                  ),
                  toolbarHeight: kToolbarHeight + 10,
                  actions: [
                    Container(
                      height: 50,
                      width: 50,
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
                          image: NetworkImage(userProvider.userModel!.photoUrl),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                SliverAppBar(
                  title: Text("Curhatan untuk anda"),
                  floating: true,
                  snap: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        try {
                          scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        } catch (e) {}
                      },
                      icon: FaIcon(FontAwesomeIcons.angleUp),
                    ),
                  ],
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10)),

                // @ List Curhatan untuk anda
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 10,
                      (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: dangerRed,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? darkPrimary
                                      : primaryColor,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            height: 250,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              highlightColor: Colors.black.withOpacity(.5),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit",
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              userProvider.userModel!.photoUrl),
                                        ),
                                        SizedBox(width: 10),
                                        Text(userProvider.userModel!.name),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
