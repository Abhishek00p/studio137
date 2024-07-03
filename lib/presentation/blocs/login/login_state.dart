import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadedState extends LoginState {
  final bool result;

  LoginLoadedState({required this.result});
}
