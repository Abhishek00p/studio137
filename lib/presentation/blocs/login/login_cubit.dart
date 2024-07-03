import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/data/firebase/firebase_auth_repository.dart';
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

  Future<void> registerUser({required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final result = await firebaseAuthRepo.register(email: email, password: password);
      emit(LoginLoadedState(result: result));
    } catch (e) {
      debugPrint('Error while register in LoginCubit : $e');
      emit(LoginErrorState());
    }
  }
}
