import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/routes.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, CheckAuthinticationState> {
  AuthBloc() : super(CheckAuthinticationState(AppRouting.onBoarding)) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckAuth) {
        final login = await getAuth();
        emit(CheckAuthinticationState(login));
      }
    });
  }

  Future<String> getAuth() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final login = sharedPreferences.getString("Home") ?? AppRouting.onBoarding;
    return login;
  }
}
