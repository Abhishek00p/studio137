import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final bool result;

  RegisterLoadedState({required this.result});
}
