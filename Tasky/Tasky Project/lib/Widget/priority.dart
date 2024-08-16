import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Helpers/applocalization.dart';

import '../constant/theme.dart';

class Priority extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> options;
  final ValueChanged<String?> onChanged;

  const Priority({
    super.key,
    required this.value,
    this.options = const [
      {'label': "Low", 'value': 'Low'},
      {'label': "Medium", 'value': 'Medium'},
      {'label': "High", 'value': 'High'},
    ],
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      selectedTileColor: ThemeColor.secondaryBackground,
      leading: const Icon(Icons.flag),
      title: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          iconEnabledColor: Colors.transparent,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.dmSans(
                color: ThemeColor.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
            suffixIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: ThemeColor.primaryColor,
              size: 40,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            hintText: "Choose_experience_Level".tr(context),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          validator: (value) => value == null ? "Validate".tr(context) : null,
          borderRadius: BorderRadius.circular(10),
          dropdownColor: ThemeColor.secondaryBackground,
          style: GoogleFonts.dmSans(
              color: ThemeColor.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          value:
              options.any((option) => option['value'] == value) ? value : null,
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((option) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 250,
                child: Text(
                  option['label']!,
                  style: GoogleFonts.dmSans(
                      color: ThemeColor.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
