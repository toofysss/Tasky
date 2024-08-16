part of 'login_bloc.dart';

class LoginState {
  final bool viewPassword;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController password;
  final TextEditingController phoneNo;
  final String currentCode;

  LoginState({
    required this.viewPassword,
    required this.isLoading,
    TextEditingController? password,
    GlobalKey<FormState>? formKey,
    TextEditingController? phoneNo,
    this.currentCode = "+964",
  })  : password = password ?? TextEditingController(),
        phoneNo = phoneNo ?? TextEditingController(),
        formKey = formKey ?? GlobalKey<FormState>();

  LoginState copyWith({
    bool? viewPassword,
    bool? isLoading,
    String? currentCode,
    TextEditingController? password,
    TextEditingController? phoneNo,
  }) {
    return LoginState(
      viewPassword: viewPassword ?? this.viewPassword,
      isLoading: isLoading ?? this.isLoading,
      currentCode: currentCode ?? this.currentCode,
      password: password ?? this.password,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }
}
