import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/Language/language_bloc.dart';

class LanguageHelper {
  static Future<void> setLanguage(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("language", languageCode);
  }

  static Future<String> getLanguage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedLanguageCode = sharedPreferences.getString("language") ?? "en";
    return cachedLanguageCode;
  }

  static Future<void> onGetSavedLanguage(
      GetSavedLanguage event, Emitter<ChangeLocaleState> emit) async {
    final String cachedLanguageCode = await getLanguage();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  static Future<void> onChangeLanguage(
      ChangeLanguage event, Emitter<ChangeLocaleState> emit) async {
    await setLanguage(event.languageCode);
    emit(ChangeLocaleState(locale: Locale(event.languageCode)));
  }
}
