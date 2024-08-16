// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/routes.dart';

class OnBoardingHelper {
  static Future<void> setAuth(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Home", AppRouting.login);
    Navigator.pushReplacementNamed(context, AppRouting.login);
  }
}
