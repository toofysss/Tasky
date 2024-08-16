import 'package:flutter/material.dart';
 import '../constant/asset.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            Assets.error,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
