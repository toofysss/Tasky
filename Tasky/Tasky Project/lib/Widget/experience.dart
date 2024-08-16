import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../constant/theme.dart';

class Experience extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> options;
  final ValueChanged<String?> onchanged;

  const Experience({
    super.key,
    this.value,
    this.options = const [
      {'label': "fresh", 'value': 'fresh'},
      {'label': "junior", 'value': 'junior'},
      {'label': "midLevel", 'value': 'midLevel'},
      {'label': "senior", 'value': 'senior'},
    ],
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        iconEnabledColor: Colors.transparent,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.arrow_drop_down_outlined,
            color: ThemeColor.iconSecondaryColor,
            size: 40,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          hintText: "Choose_experience_Level".tr(context),
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
        validator: (value) => value == null ? "Validate".tr(context) : null,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: ThemeColor.primaryBackground,
        isExpanded: true,
        style: GoogleFonts.dmSans(
            color: ThemeColor.textPrimaryColor,
            fontSize: 16,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700),
        value: options.any((option) => option['value'] == value) ? value : null,
        hint: Text(
          "Choose_experience_Level".tr(context),
          style: GoogleFonts.dmSans(
              color: ThemeColor.textPrimaryColor,
              fontSize: 16,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500),
        ),
        onChanged: onchanged,
        items: options.map<DropdownMenuItem<String>>((option) {
          return DropdownMenuItem<String>(
            value: option['value'],
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 152,
              child: Text(
                option['label']!.tr(context),
                style: GoogleFonts.dmSans(
                    color: ThemeColor.textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
