import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../constant/theme.dart';

class Progress extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> options;
  final ValueChanged<String?> onchanged;

  const Progress({
    super.key,
    this.value,
    this.options = const [
      {'label': "Inpogress", 'value': 'inpogress'},
      {'label': "Waiting", 'value': 'waiting'},
      {'label': "Finished", 'value': 'finished'},
    ],
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        iconEnabledColor: Colors.transparent,
        decoration: const InputDecoration(
          fillColor: ThemeColor.secondaryBackground,
          filled: true,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              color: ThemeColor.primaryColor,
              size: 40,
            ),
          ),
          contentPadding: EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            right: 20.0,
            bottom: 24.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        validator: (value) => value == null ? "Validate".tr(context) : null,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: ThemeColor.secondaryBackground,
        isExpanded: true,
        value: options.any((option) => option['value'] == value) ? value : null,
        onChanged: onchanged,
        items: options.map<DropdownMenuItem<String>>((option) {
          return DropdownMenuItem<String>(
            value: option['value'],
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 152,
              child: Text(
                option['label']!.tr(context),
                style: GoogleFonts.dmSans(
                    color: ThemeColor.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
