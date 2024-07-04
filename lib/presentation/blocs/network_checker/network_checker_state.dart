import 'package:equatable/equatable.dart';

class NetworkCheckerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkCheckerLoadingState extends NetworkCheckerState {}

class NetworkCheckerLoadedState extends NetworkCheckerState {}

class LoacationCheckerLoadingState extends NetworkCheckerState {}

class LocationCheckerLoadedState extends NetworkCheckerState {}
