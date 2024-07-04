import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRepo {
  final _fauth = FirebaseAuth.instance;

  bool checkIfUserAlreadyAuthenticatef() {
    return _fauth.currentUser != null;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _fauth.signInWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('some error occured while login user from firebase : $e');
      return false;
    }
  }

  Future<bool> register({required String email, required String password}) async {
    try {
      final userCred = await _fauth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('some error occured while registering user in firebase : $e');
      return false;
    }
  }

  Future<void> logOutUser() async {
    try {
      await _fauth.signOut();
    } catch (e) {
      debugPrint('some error occured while signing Out user in firebase : $e');
    }
  }
}
