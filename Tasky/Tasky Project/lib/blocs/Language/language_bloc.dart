import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/languagehelper.dart';
part 'language_event.dart';
part 'language_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, ChangeLocaleState> {
  LocaleBloc() : super(ChangeLocaleState(locale: const Locale('en'))) {
    //////////////////// Get Language ////////////////

    on<GetSavedLanguage>(LanguageHelper.onGetSavedLanguage);
    //////////////////// Set Language ////////////////

    on<ChangeLanguage>(LanguageHelper.onChangeLanguage);
  }
}
