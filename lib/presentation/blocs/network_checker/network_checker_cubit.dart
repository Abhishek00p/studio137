import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:studio13/presentation/blocs/network_checker/network_checker_state.dart';
import 'package:permission_handler/permission_handler.dart';

class NetworkCheckerCubit extends Cubit<NetworkCheckerState> {
  NetworkCheckerCubit() : super(NetworkCheckerState());

  Future<void> checkNetworkAndLocation() async {
    emit(NetworkCheckerLoadingState());
    if (await _checkNetwork()) {
      emit(NetworkCheckerLoadedState());
    }
    emit(LoacationCheckerLoadingState());
    if (await _checkLocation() ?? false) {
      emit(LocationCheckerLoadedState());
    }
  }

  Future<bool> _checkNetwork() async {
    return await InternetConnectionChecker().hasConnection;
  }

  Future<bool?> _checkLocation() async {
    await Permission.location.request();
    if (await Permission.location.isDenied || await Permission.location.isPermanentlyDenied) {
      final result = await Geolocator.checkPermission();
      if (result == LocationPermission.whileInUse || result == LocationPermission.always) {
        return true;
      } else {
        final res = await Geolocator.requestPermission();
        if (res == LocationPermission.whileInUse || res == LocationPermission.always) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return true;
    }
  }
}
