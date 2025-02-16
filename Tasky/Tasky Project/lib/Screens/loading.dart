import 'package:flutter/material.dart';

import '../constant/theme.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:   CircularProgressIndicator(
        color: ThemeColor.primaryColor,
      ),
    );
  }
}
