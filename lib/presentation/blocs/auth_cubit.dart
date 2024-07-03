import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.unknown);

  void updateStatus(AuthStatus status) {
    emit(status);
  }
}

enum AuthStatus {
  unauthenticated,
  authenticated,
  unknown,
}
