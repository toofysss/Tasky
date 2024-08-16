part of 'language_bloc.dart';

abstract class LocaleEvent {}

class GetSavedLanguage extends LocaleEvent {}

class ChangeLanguage extends LocaleEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}
