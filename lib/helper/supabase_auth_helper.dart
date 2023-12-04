import 'dart:async';

import 'package:curheart/helper/firebase_firestore_helper.dart';
import 'package:curheart/main.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/provider/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthHelper {
  static final _auth = supabase.auth;

  // ! Listen to auth events
  static Session? currentSession = _auth.currentSession;

  // ! Sign in with Email & Password
  static Future<Object> signIn(
    UserProvider userProvider, {
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse authResponse = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestoreHelper.getUser(
          authResponse.user!.id, userProvider);

      return "success";
    } catch (e) {
      return e;
    }
  }

  // ! Sign Up with Email & Password
  static Future<Object> signUp({
    required String email,
    required String name,
    required String photoUrl,
    required String password,
  }) async {
    try {
      AuthResponse authResponse = await _auth.signUp(
        email: email,
        password: password,
      );

      await FirebaseFirestoreHelper.addUser(UserModel(
        userId: authResponse.user!.id,
        email: email,
        name: name,
        photoUrl: "",
      ));

      return "success";
    } catch (e) {
      return e;
    }
  }

  // ! Sign Out
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
