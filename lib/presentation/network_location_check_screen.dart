import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/core/router.dart';
import 'package:studio13/presentation/blocs/network_checker/network_checker_cubit.dart';
import 'package:studio13/presentation/blocs/network_checker/network_checker_state.dart';

class NetworkLocationPermissionScreen extends StatefulWidget {
  const NetworkLocationPermissionScreen({super.key});

  @override
  State<NetworkLocationPermissionScreen> createState() => _NetworkLocationPermissionScreenState();
}

class _NetworkLocationPermissionScreenState extends State<NetworkLocationPermissionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NetworkCheckerCubit>().checkNetworkAndLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCheckerCubit, NetworkCheckerState>(
      listener: (context, state) {
        if (state is LocationCheckerLoadedState) {
          debugPrint('permission done for loc');
          appRouter.goNamed(AppRouterStrings.home);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    'd',
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'deliva',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator(),
                      const SizedBox(
                        width: 15,
                      ),
                      BlocBuilder<NetworkCheckerCubit, NetworkCheckerState>(
                        builder: (context, state) {
                          if (state is NetworkCheckerLoadingState) {
                            return const Text(
                              'Checking Internet Connection....',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          if (state is LoacationCheckerLoadingState) {
                            return const Text(
                              'Checking Location Permissions....',
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          return const SizedBox();
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
