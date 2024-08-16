part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ViewPassword extends LoginEvent {}

class ChangeCurrentCode extends LoginEvent {
  final String currentCode;
  ChangeCurrentCode({required this.currentCode});
}

class SignUpComplete extends LoginEvent {}
