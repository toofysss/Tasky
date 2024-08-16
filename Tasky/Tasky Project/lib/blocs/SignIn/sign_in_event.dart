part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class ViewPassword extends SignInEvent {}

class ChangeCurrentCode extends SignInEvent {
  final String currentCode;
  ChangeCurrentCode({required this.currentCode});
}

class ChangeDropDown extends SignInEvent {
  final String value;
  ChangeDropDown({required this.value});
}

class SignInComplete extends SignInEvent {}
