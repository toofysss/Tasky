// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      hoverColor: Colors.transparent,
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        HugeIcons.strokeRoundedArrowLeft04,
        color: Colors.black,
        size: 24,
      ),
    );
  }
}
