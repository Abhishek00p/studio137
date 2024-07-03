import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/core/router.dart';
import 'package:studio13/presentation/blocs/login/login_cubit.dart';
import 'package:studio13/presentation/blocs/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          SnackBar snackBar = const SnackBar(content: Text('Failed to Login'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is LoginLoadedState) {
          SnackBar snackBar = SnackBar(content: Text(state.result ? 'Successfully Logged In' : 'Failed to Login user'));
          appRouter.refresh();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            const Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)), label: const Text('Email'), hintText: 'test@gmail.com'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)), label: const Text('Password'), hintText: '123456'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().loginUser(email: emailController.text, password: passController.text);
                        },
                        child: const Text('Login'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    appRouter.goNamed(AppRouterStrings.register);
                  },
                  child: Text(
                    'Or Register here',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
