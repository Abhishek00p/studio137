import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio13/presentation/blocs/auth_cubit.dart';
import 'package:studio13/presentation/home.dart';
import 'package:studio13/presentation/login_screen.dart';
import 'package:studio13/presentation/network_location_check_screen.dart';
import 'package:studio13/presentation/register.dart';

class AppRouterStrings {
  static const login = '/';
  static const home = '/home';
  static const register = '/register';
  static const networkChecker = '/network';
}

final appRouter = GoRouter(
    redirect: (context, state) {
      final status = context.read<AuthCubit>().state;
      if (status == AuthStatus.authenticated) {
        debugPrint('status authenticated');

        if (state.fullPath == AppRouterStrings.login) {
          debugPrint('Lets go back to networkchecker');
          return AppRouterStrings.networkChecker;
        }
      }
      if (status == AuthStatus.unauthenticated) {
        if (state.fullPath != AppRouterStrings.login && state.fullPath != AppRouterStrings.register) {
          return AppRouterStrings.login;
        }
      }
      if (status == AuthStatus.unknown) {
        if (state.fullPath != AppRouterStrings.login && state.fullPath != AppRouterStrings.register) {
          return AppRouterStrings.login;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRouterStrings.login,
        name: AppRouterStrings.login,
        builder: (context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouterStrings.home,
        name: AppRouterStrings.home,
        builder: (context, GoRouterState state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRouterStrings.register,
        name: AppRouterStrings.register,
        builder: (context, GoRouterState state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRouterStrings.networkChecker,
        name: AppRouterStrings.networkChecker,
        builder: (context, GoRouterState state) => const NetworkLocationPermissionScreen(),
      ),
    ]);
