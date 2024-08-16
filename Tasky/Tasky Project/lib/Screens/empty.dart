import 'package:flutter/material.dart';

import '../constant/asset.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        Assets.empty,
      ),
    );
  }
}
