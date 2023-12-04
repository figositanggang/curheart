import 'package:curheart/start/auth_state_page.dart';
import 'package:curheart/utils/const_variables.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    setIsOpened();
  }

  void setIsOpened() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setBool(isOpenedKey, true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrimaryButton(
                text: "Mulai",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context, CustomRoute(AuthStatePage()), (route) => false);
                },
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/illustration.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
