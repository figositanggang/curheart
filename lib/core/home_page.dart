import 'package:curheart/core/add_curheart.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/main.dart';
import 'package:curheart/provider/curheart_provider.dart';
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
  late CurheartProvider curheartProvider;

  final currentUser = supabase.auth.currentUser!;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    curheartProvider = Provider.of<CurheartProvider>(context, listen: false);
  }

  // ! Get current user and all curhearts
  Future<void> getData() async {
    await Future.delayed(Duration(milliseconds: 500));

    if (userProvider.userModel == null) {
      await FirebaseFirestoreHelper.getUser(currentUser.id, userProvider);
    }

    await FirebaseFirestoreHelper.getAllCurheart(curheartProvider);
  }

  // ! Refresh Screen
  Future<void> refresh() async {
    getData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final curheartProvider = Provider.of<CurheartProvider>(context);

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        // ? WAITING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FullScreenLoading();
        }

        // ? SUCCESS
        return Scaffold(
          drawer: Drawer(),
          drawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: MediaQuery.sizeOf(context).width - 100,

          // @ Refresher
          body: RefreshIndicator(
            onRefresh: refresh,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
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
                            image:
                                NetworkImage(userProvider.userModel!.photoUrl),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                // @ List Curheart
                curheartProvider.allCurheart.isNotEmpty
                    ? SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: curheartProvider.allCurheart.length,
                            (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: CureheartCard(
                                  userModel: userProvider.userModel!,
                                  curheartModel:
                                      curheartProvider.allCurheart[index],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height -
                              kToolbarHeight,
                          child: Center(
                            child: Text("Belum ada curheart"),
                          ),
                        ),
                      ),
              ],
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
                CustomRoute(AddCurheart(
                  userModel: userProvider.userModel!,
                )),
              );
            },
          ),
        );
      },
    );
  }
}
