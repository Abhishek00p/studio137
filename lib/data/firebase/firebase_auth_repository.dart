import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRepo {
  final _fauth = FirebaseAuth.instance;
  @override
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

  @override
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
}
