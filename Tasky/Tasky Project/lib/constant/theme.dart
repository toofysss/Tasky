import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColor {
  static const Color primaryColor = Color(0xff5F33E1);
  static const Color primaryBackground = Color(0xffffffff);
  static const Color secondaryBackground = Color(0xffF0ECFF);

  // Loading and Tab Colors
  static const Color loadingIndicatorColor = Colors.white;
  static const Color tabBackgroundColor = Colors.white;
  static const Color tabUnselectedColor = Color(0xff7C7C80);

  // Icon Colors
  static const Color iconPrimaryColor = Color(0xff5F33E1);
  static const Color iconSecondaryColor = Color(0xffBABABA);

  // Text Colors
  static const Color textPrimaryColor = Color(0xff24252C);
  static const Color textSecondaryColor = Color(0xff6E6A7C);
  static const Color profileTextColor = Color(0xff2F2F2F);

  // Border and Popup Colors
  static const Color borderColor = Color(0xffBABABA);
  static const Color popupDeleteColor = Color(0xffFF7D53);

  // Priority Colors
  static const Color highPriorityColor = Color(0xffFF7D53);
  static const Color mediumPriorityColor = Color(0xff5F33E1);
  static const Color lowPriorityColor = Color(0xff0087FF);

  // Status Colors
  static const Color waitingStatusBackground = Color(0xffFFE4F2);
  static const Color inProgressStatusBackground = Color(0xffF0ECFF);
  static const Color finishedStatusBackground = Color(0xffE3F2FF);

  static const Color waitingStatusColor = Color(0xffFF7D53);
  static const Color inProgressStatusColor = Color(0xff5F33E1);
  static const Color finishedStatusColor = Color(0xff0087FF);
}

ThemeData theme(BuildContext context) {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    focusColor: Colors.transparent,
    listTileTheme: ListTileThemeData(
      iconColor: ThemeColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      horizontalTitleGap: 20,
      selectedTileColor: const Color(0xffF5F5F5),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(ThemeColor.textPrimaryColor),
      ),
    ),
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.dmSans(
            color: const Color(0xff24252C),
            fontSize: 16,
            fontWeight: FontWeight.w700),
        elevation: 0,
        backgroundColor: Colors.transparent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        alignment: Alignment.center,
        iconSize: const WidgetStatePropertyAll(20),
        backgroundColor: const WidgetStatePropertyAll(ThemeColor.primaryColor),
        padding:
            const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
        iconColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.dmSans(
            fontSize: 19.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
