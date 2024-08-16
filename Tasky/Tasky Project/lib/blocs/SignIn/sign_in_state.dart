part of 'sign_in_bloc.dart';

class SigninState {
  final bool viewPassword;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController password;
  final TextEditingController phoneNo;
  final TextEditingController name;
  final TextEditingController yearsOfExperence;
  final TextEditingController address;
  final String exprenceLevel;
  final String currentCode;

  SigninState({
    required this.viewPassword,
    required this.isLoading,
    GlobalKey<FormState>? formKey,
    TextEditingController? password,
    TextEditingController? phoneNo,
    TextEditingController? name,
    TextEditingController? yearsOfExperence,
    TextEditingController? address,
    this.exprenceLevel = "",
    this.currentCode = "+964",
  })  : password = password ?? TextEditingController(),
        phoneNo = phoneNo ?? TextEditingController(),
        name = name ?? TextEditingController(),
        yearsOfExperence = yearsOfExperence ?? TextEditingController(),
        address = address ?? TextEditingController(),
        formKey = formKey ?? GlobalKey<FormState>();

  SigninState copyWith({
    bool? viewPassword,
    bool? isLoading,
    String? currentCode,
    String? exprenceLevel,
    TextEditingController? password,
    TextEditingController? phoneNo,
    TextEditingController? name,
    TextEditingController? yearsOfExperence,
    TextEditingController? address,
  }) {
    return SigninState(
      viewPassword: viewPassword ?? this.viewPassword,
      isLoading: isLoading ?? this.isLoading,
      currentCode: currentCode ?? this.currentCode,
      password: password ?? this.password,
      phoneNo: phoneNo ?? this.phoneNo,
      name: name ?? this.name,
      yearsOfExperence: yearsOfExperence ?? this.yearsOfExperence,
      address: address ?? this.address,
      exprenceLevel: exprenceLevel ?? this.exprenceLevel,
    );
  }
}
