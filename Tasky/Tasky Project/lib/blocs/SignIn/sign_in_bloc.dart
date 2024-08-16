// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Helpers/applocalization.dart';
import '../../Models/loginmodel.dart';
import '../../Services/api.dart';
import '../../constant/routes.dart';
import '../../constant/theme.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SigninState> {
  BuildContext context;
  SignInBloc(this.context)
      : super(SigninState(viewPassword: true, isLoading: false)) {
    //////////////////// View Password ////////////////

    on<ViewPassword>((event, emit) {
      emit(state.copyWith(viewPassword: !state.viewPassword));
    });

    //////////////////// Change Current Code ////////////////

    on<ChangeCurrentCode>((event, emit) {
      emit(state.copyWith(currentCode: event.currentCode));
    });

    //////////////////// Change Experence Level ////////////////

    on<ChangeDropDown>((event, emit) {
      emit(state.copyWith(exprenceLevel: event.value));
    });

    //////////////////// Sign In ////////////////

    on<SignInComplete>((event, emit) async {
      if (state.formKey.currentState!.validate()) {
        emit(state.copyWith(isLoading: true));
        var link = Uri.parse('$api/auth/register');
        Map<String, dynamic> data = {
          "phone": "${state.currentCode}${state.phoneNo.text}",
          "password": state.password.text,
          "displayName": state.name.text,
          "experienceYears": state.yearsOfExperence.text,
          "address": state.address.text,
          "level": state.exprenceLevel
        };
        var headers = {
          'Content-Type': 'application/json',
        };

        var response = await http.post(
          link,
          headers: headers,
          body: jsonEncode(data),
        );

        //////////////////// Success Login ////////////////
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> jsonMap = jsonDecode(response.body);
          LoginModels login = LoginModels.fromJson(jsonMap);
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("ID", login.sId!);
          sharedPreferences.setString("Token", login.accessToken!);
          sharedPreferences.setString("RefreshToken", login.refreshToken!);
          sharedPreferences.setString("Home", AppRouting.homepage);
          Navigator.pushReplacementNamed(context, AppRouting.homepage);
        } else if (response.statusCode == 422) {
          emit(state.copyWith(isLoading: false));

          final snackBar = SnackBar(
            content: Text(
              "AlredyAccount".tr(context),
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
        } else {
          emit(state.copyWith(isLoading: false));

          final snackBar = SnackBar(
            content: Text(
              "ErrorSignIn".tr(context),
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
      }
    });
  }
}
