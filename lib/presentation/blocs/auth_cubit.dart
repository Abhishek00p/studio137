import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/firebase/firebase_auth_repository.dart';

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.unknown);

  FirebaseAuthRepo firebaseAuthRepo = FirebaseAuthRepo();
  void updateStatus(AuthStatus status) {
    emit(status);
  }

  void checkAuthentication() {
    if (firebaseAuthRepo.checkIfUserAlreadyAuthenticatef()) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }
  }
}

enum AuthStatus {
  unauthenticated,
  authenticated,
  unknown,
}
