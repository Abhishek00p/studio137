import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/data/firebase/firebase_auth_repository.dart';
import 'package:studio13/presentation/blocs/register/register._state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  final FirebaseAuthRepo firebaseAuthRepo = FirebaseAuthRepo();

  Future<void> registerUser({required String email, required String password}) async {
    try {
      emit(RegisterLoadingState());
      final result = await firebaseAuthRepo.register(email: email, password: password);
      emit(RegisterLoadedState(result: result));
    } catch (e) {
      debugPrint('Error while register in RegisterCubit : $e');
      emit(RegisterErrorState());
    }
  }
}
