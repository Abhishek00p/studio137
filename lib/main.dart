import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/firebase_options.dart';
import 'package:studio13/presentation/blocs/auth_cubit.dart';
import 'package:studio13/core/router.dart';
import 'package:studio13/presentation/blocs/login/login_cubit.dart';
import 'package:studio13/presentation/blocs/network_checker/network_checker_cubit.dart';
import 'package:studio13/presentation/blocs/register/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..checkAuthentication(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => NetworkCheckerCubit(),
        ),
      ],
      child: Material(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
        ),
      ),
    );
  }
}
