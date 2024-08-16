import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../constant/theme.dart';

class Inputphone extends StatelessWidget {
  final TextEditingController controller;
  final String countryCode;
  final Function(CountryCode)? onchanged;
  const Inputphone({
    super.key,
    required this.countryCode,
    required this.onchanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: ThemeColor.borderColor),
      ),
      child: Row(
        children: [
          CountryCodePicker(
            onChanged: onchanged,
            initialSelection: countryCode,
            showFlagDialog: true,
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            padding: EdgeInsets.zero,
            searchStyle: const TextStyle(
                color: ThemeColor.textPrimaryColor,
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w400),
            showDropDownButton: true,
            boxDecoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            dialogTextStyle: GoogleFonts.dmSans(
                color: ThemeColor.textPrimaryColor,
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w400),
            textStyle: GoogleFonts.dmSans(
              fontSize: 16,
              color: ThemeColor.textPrimaryColor,
            ),
            searchDecoration: const InputDecoration(
              hintText: 'Search...',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: .5,
                  color: ThemeColor.textPrimaryColor,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: .5,
                  color: ThemeColor.textPrimaryColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: .5,
                  color: ThemeColor.textPrimaryColor,
                ),
              ),
              hintStyle: TextStyle(
                  color: ThemeColor.textPrimaryColor,
                  fontSize: 14,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: TextFormField(
              validator: (value) =>
                  controller.text.isEmpty ? "Validate".tr(context) : null,
              cursorColor: ThemeColor.primaryColor,
              style: const TextStyle(
                  color: ThemeColor.textPrimaryColor,
                  fontSize: 14,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400),
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '123 456-7890',
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}
