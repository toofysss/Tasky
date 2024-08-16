import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../constant/theme.dart';

class CustomTextField extends StatelessWidget {
  final int maxline;
  final String hint;
  final bool readonly;
  final bool validate;

  final TextEditingController controller;
  final Widget? suffix;
  final bool obscure;
  const CustomTextField({
    super.key,
    this.validate = false,
    this.obscure = false,
    required this.controller,
    this.maxline = 1,
    this.suffix,
    this.readonly = false,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) =>
          validate && controller.text.isEmpty ? "Validate".tr(context) : null,
      obscureText: obscure,
      readOnly: readonly,
      controller: controller,
      maxLines: maxline,
      style: GoogleFonts.dmSans(
          color: ThemeColor.textPrimaryColor,
          fontSize: 14,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        hintText: hint,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ThemeColor.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ThemeColor.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ThemeColor.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
