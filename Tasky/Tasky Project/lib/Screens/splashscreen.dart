import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/constant/asset.dart';

import '../blocs/Auth/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final authState = context.read<AuthBloc>().state.home;
        Navigator.of(context).pushReplacementNamed(authState);
      },
    );

    return Scaffold(
        body: Image.asset(
      Assets.splash,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    ));
  }
}
