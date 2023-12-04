import 'package:curheart/firebase_options.dart';
import 'package:curheart/provider/user_provider.dart';
import 'package:curheart/start/auth_state_page.dart';
import 'package:curheart/utils/const_variables.dart';
import 'package:curheart/utils/custom_theme.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:curheart/start/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: "https://ilgbmfiolgpuplpawrtp.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlsZ2JtZmlvbGdwdXBscGF3cnRwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE2ODA0NjUsImV4cCI6MjAxNzI1NjQ2NX0.xr37qqdCqVHzEO2Lse26Vis6yK1lKzpaDFiRHc8JR-o",
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const FirstOpen(),
    );
  }
}

// ! Check if user has opened the app for the first time
class FirstOpen extends StatefulWidget {
  const FirstOpen({super.key});

  @override
  State<FirstOpen> createState() => _FirstOpenState();
}

class _FirstOpenState extends State<FirstOpen> {
  @override
  void initState() {
    super.initState();

    getSP();
  }

  Future<bool?> getSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isOpened;

    try {
      isOpened = sharedPreferences.getBool(isOpenedKey);
    } catch (e) {}

    return isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSP(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FullScreenLoading();
        }

        if (snapshot.hasData) {
          return AuthStatePage();
        }

        return WelcomePage();
      },
    );
  }
}
