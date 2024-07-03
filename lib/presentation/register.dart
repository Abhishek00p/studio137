import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/core/router.dart';
import 'package:studio13/presentation/blocs/login/login_cubit.dart';
import 'package:studio13/presentation/blocs/login/login_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          SnackBar snackBar = const SnackBar(content: Text('Failed to Register'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is LoginLoadedState) {
          SnackBar snackBar = SnackBar(content: Text(state.result ? 'Successfully Registered' : 'Failed to Register user'));
          appRouter.refresh();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            const Text(
              'Register',
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
                        child: const Text('Create Acccount'))
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
                    appRouter.pushReplacementNamed(AppRouterStrings.login);
                  },
                  child: Text(
                    'Or Login here',
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
