import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/firebase/firebase_auth_repository.dart';
import 'package:studio13/presentation/blocs/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final FirebaseAuthRepo firebaseAuthRepo = FirebaseAuthRepo();
  Future<void> loginUser({required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final result = await firebaseAuthRepo.login(email: email, password: password);
      emit(LoginLoadedState(result: result));
    } catch (e) {
      debugPrint('Error while login in LoginCubit : $e');
      emit(LoginErrorState());
    }
  }

  Future<void> logOutUser() async {
    try {
      await firebaseAuthRepo.logOutUser();
    } catch (e) {
      debugPrint('Error while Logout in LoginCubit : $e');
    }
  }
}
