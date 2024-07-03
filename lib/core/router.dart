import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio13/presentation/blocs/auth_cubit.dart';
import 'package:studio13/presentation/home.dart';
import 'package:studio13/presentation/login_screen.dart';
import 'package:studio13/presentation/register.dart';

class AppRouterStrings {
  static const login = '/';
  static const home = '/home';
  static const register = '/register';
}

final appRouter = GoRouter(
    redirect: (context, state) {
      final status = context.read<AuthCubit>().state;
      if (status == AuthStatus.authenticated) {
        if (state.fullPath == AppRouterStrings.login) {
          return AppRouterStrings.home;
        }
      }
      if (status == AuthStatus.unauthenticated) {
        if (state.fullPath != AppRouterStrings.login) {
          return AppRouterStrings.login;
        }
      }
      if (status == AuthStatus.unknown) {
        return AppRouterStrings.login;
      }
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
    ]);
