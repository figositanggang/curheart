import 'package:curheart/auth/login_page.dart';
import 'package:curheart/core/home_page.dart';
import 'package:curheart/main.dart';
import 'package:flutter/material.dart';

// ! Check if user logged in or not
class AuthStatePage extends StatelessWidget {
  const AuthStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;

    if (session != null) {
      return HomePage();
    }

    return LoginPage();
  }
}
