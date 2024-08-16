// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../Helpers/applocalization.dart';

import '../../Services/api.dart';
import '../../constant/routes.dart';
import '../../constant/theme.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  BuildContext context;
  LogoutBloc({required this.context}) : super(LogoutInitial()) {
    //////////////////// Logout ////////////////

    on<Logout>((event, emit) async {
      try {
        final sharedPreferences = await SharedPreferences.getInstance();
        final token = sharedPreferences.getString("Token") ?? "";
        final link = Uri.parse("$api/auth/logout");
        Map<String, dynamic> data = {"token": token};
        Map<String, String> header = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };
        final response =
            await http.post(link, body: jsonEncode(data), headers: header);

        if (response.statusCode == 200 || response.statusCode == 201) {
          clear(sharedPreferences);
          emit(LogoutSuccess());
        } else {
          final snackBar = SnackBar(
            content: Text(
              "ErrorLogout".tr(context),
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: ThemeColor.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            duration: const Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ThemeColor.secondaryBackground,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        emit(LogoutSuccess());
      }
    });
  }

  clear(final sharedPreferences) {
    sharedPreferences.remove("ID");
    sharedPreferences.remove("Token");
    sharedPreferences.remove("RefreshToken");
    sharedPreferences.setString("Home", AppRouting.login);
  }
}
