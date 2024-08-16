import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../Widget/customtextfield.dart';
import '../constant/routes.dart';
import '../constant/theme.dart';
import '../Widget/inputphone.dart';
import '../blocs/Login/login_bloc.dart';
import '../constant/asset.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        //////////////////// Image ////////////////
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 500,
                            minWidth: 330,
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.onBoarding),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            children: [
                              //////////////////// Title ////////////////
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Login".tr(context),
                                  style: GoogleFonts.dmSans(
                                      fontSize: 24,
                                      color: ThemeColor.textPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      height: 1.23),
                                ),
                              ),

                              const SizedBox(height: 20),

                              //////////////////// Input With Country Code ////////////////
                              Inputphone(
                                controller: state.phoneNo,
                                onchanged: (country) {
                                  context.read<LoginBloc>().add(
                                        ChangeCurrentCode(
                                            currentCode: country.dialCode!),
                                      );
                                },
                                countryCode: state.currentCode,
                              ),
                              const SizedBox(height: 20),

                              //////////////////// Password ////////////////
                              CustomTextField(
                                validate: true,
                                obscure: state.viewPassword,
                                controller: state.password,
                                hint: "Password".tr(context),
                                suffix: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(ViewPassword());
                                    },
                                    icon: Icon(
                                        state.viewPassword
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        color: ThemeColor.iconSecondaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              //////////////////// Sign In Button ////////////////
                              SizedBox(
                                height: 49,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (state.formKey.currentState
                                            ?.validate() ??
                                        false) {
                                      context
                                          .read<LoginBloc>()
                                          .add(SignUpComplete());
                                    }
                                  },
                                  child: state.isLoading
                                      ? const CircularProgressIndicator(
                                          color:
                                              ThemeColor.loadingIndicatorColor)
                                      : Text(
                                          'LoginButton'.tr(context),
                                          style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style
                                              ?.textStyle
                                              ?.resolve({}),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              //////////////////// Sign Up ////////////////
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "NotHaveAccount".tr(context),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      letterSpacing: .2,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7F7F7F),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushReplacementNamed(
                                            AppRouting.singIn),
                                    child: Text(
                                      'SignUpHere'.tr(context),
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        color: ThemeColor.primaryColor,
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
