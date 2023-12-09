import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/main.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/curheart_provider.dart';
import 'package:curheart/utils/const_variables.dart';
import 'package:curheart/utils/custom_methods.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCurheart extends StatefulWidget {
  final UserModel userModel;
  const AddCurheart({super.key, required this.userModel});

  @override
  State<AddCurheart> createState() => _AddCurheartState();
}

class _AddCurheartState extends State<AddCurheart> {
  final formKey = GlobalKey<FormState>();
  final currentUser = supabase.auth.currentUser!;

  late TextEditingController titleCurheart;
  late CurheartProvider curheartProvider;

  int? selectedChip;

  @override
  void initState() {
    super.initState();
    curheartProvider = Provider.of<CurheartProvider>(context, listen: false);

    titleCurheart = TextEditingController();
  }

  // ! Post a Curheart
  void postCurheart(CurheartModel curheartModel) async {
    showDialog(
        context: context,
        builder: (context) => FullScreenLoading(
              text: "Posting curheart...",
            ));
    String res = await FirebaseFirestoreHelper.postCurheart(curheartModel);

    if (res == "success") {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }

    print(res);
  }

  Future<void> aw() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool pop = false;

        await showDialog(
          context: context,
          builder: (context) => MyDialog(
            onYes: () {
              pop = true;
              curheartProvider.isiCurheart.text = "";

              Navigator.pop(context);
            },
          ),
        );

        return pop;
      },
      child: Scaffold(
        // @ App Bar
        appBar: MyAppBar(
          context,
          title: Text("Tambah curheart"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => MyDialog(
                onYes: () {
                  curheartProvider.isiCurheart.text = "";

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // @ Title Curheart
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: reversedColor(context),
                        boxShadow: [
                          BoxShadow(
                            color: reversedPrimary(context),
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: MyTextField(
                        controller: titleCurheart,
                        label: "Judul cuheart",
                        labelColor: directColor(context),
                        valueColor: directColor(context),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    SizedBox(height: 20),

                    // @ Isi Curheart
                    Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.sizeOf(context).height / 2),
                      decoration: BoxDecoration(
                        color: reversedColor(context),
                        boxShadow: [
                          BoxShadow(
                            color: reversedPrimary(context),
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Isi Curheart",
                                style: TextStyle(color: directColor(context)),
                              ),
                              Text(
                                "Kata: ${RegExp(r"[\w-]+").allMatches(context.watch<CurheartProvider>().isiCurheart.text).length}",
                                style: TextStyle(color: directColor(context)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // @ TextField Isi Curheart
                          MyTextField(
                            controller: curheartProvider.isiCurheart,
                            label: "",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Masih kosong...";
                              }
                              if (RegExp(r"[\w-]+")
                                      .allMatches(context
                                          .read<CurheartProvider>()
                                          .isiCurheart
                                          .text)
                                      .length <
                                  20) {
                                return "Minimal 20 kata...";
                              }

                              return null;
                            },
                            counterText: "Minimal 20 kata",
                            labelColor: directColor(context),
                            valueColor: directColor(context),
                            contentPadding: EdgeInsets.all(10),
                            maxLines: null,
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            onChanged: (value) {
                              curheartProvider.setIsiCurheart = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // @ Emoji
                    MyContainer(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emoji",
                            style: TextStyle(color: directColor(context)),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: List.generate(
                              emoji.length,
                              (index) => MyChip(
                                label: Text(
                                  emoji[index]["emoji"],
                                  style: TextStyle(fontSize: 40),
                                ),
                                selected: selectedChip == index,
                                onSelected: (value) {
                                  setState(() {
                                    selectedChip = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // @ Submit Button
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: MyButton(
            text: "Post",
            borderRadius: BorderRadius.zero,
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                return;
              } else if (selectedChip == null) {
                showSnackBar(
                    context, MySnackBar(content: "Emoji belum dipilih"));
                return;
              }

              postCurheart(
                CurheartModel(
                  id: "",
                  createdBy: currentUser.id,
                  type: emoji[selectedChip!]["type"],
                  title: titleCurheart.text.trim(),
                  isiCurheart: curheartProvider.isiCurheart.text.trim(),
                  color: emoji[selectedChip!]["type"] == "Senang"
                      ? primaryColor.value
                      : dangerRed.value,
                  createdAt: Timestamp.fromDate(DateTime.now()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
