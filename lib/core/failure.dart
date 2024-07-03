class Failure {
  final String message;

  Failure({required this.message});
}

class FirebaseLoginFailure extends Failure {
  FirebaseLoginFailure({required super.message});
}

class FirebaseRegisterFailure extends Failure {
  FirebaseRegisterFailure({required super.message});
}
