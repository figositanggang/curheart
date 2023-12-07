import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/curheart_provider.dart';
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

  late TextEditingController titleCurheart;
  late CurheartProvider curheartProvider;
  // late TextEditingController isiCurheart;

  @override
  void initState() {
    super.initState();
    curheartProvider = Provider.of<CurheartProvider>(context, listen: false);

    titleCurheart = TextEditingController();
    // isiCurheart = TextEditingController();
  }

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

              Navigator.pop(context);
            },
          ),
        );

        return pop;
      },
      child: Scaffold(
        appBar: MyAppBar(
          context,
          title: Text("Tambah curheart"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => MyDialog(
                onYes: () {
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // @ Title Curheart
                  Container(
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
                ],
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
              if (formKey.currentState!.validate()) {}
            },
          ),
        ),
      ),
    );
  }
}
