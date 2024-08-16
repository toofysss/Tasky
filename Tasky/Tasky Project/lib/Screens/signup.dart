import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../Widget/customtextfield.dart';
import '../Widget/experience.dart';
import '../blocs/SignIn/sign_in_bloc.dart';
import '../constant/routes.dart';
import '../constant/theme.dart';
import '../Widget/inputphone.dart';
import '../constant/asset.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(context),
      child: BlocBuilder<SignInBloc, SigninState>(
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
                                  "SignIn".tr(context),
                                  style: GoogleFonts.dmSans(
                                      fontSize: 24,
                                      color: ThemeColor.textPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      height: 1.23),
                                ),
                              ),

                              const SizedBox(height: 20),
                              //////////////////// Name ////////////////
                              CustomTextField(
                                validate: true,
                                controller: state.name,
                                hint: "${"Name".tr(context)}...",
                              ),
                              const SizedBox(height: 20),
                              //////////////////// Input With Country Code ////////////////
                              Inputphone(
                                controller: state.phoneNo,
                                onchanged: (country) {
                                  context.read<SignInBloc>().add(
                                        ChangeCurrentCode(
                                            currentCode: country.dialCode!),
                                      );
                                },
                                countryCode: state.currentCode,
                              ),

                              const SizedBox(height: 20),

                              //////////////////// Years of experience ////////////////
                              CustomTextField(
                                validate: true,
                                controller: state.yearsOfExperence,
                                hint: "${"Yearsexperience".tr(context)}...",
                              ),
                              const SizedBox(height: 20),

                              //////////////////// Choose experience Level ////////////////
                              Experience(
                                value: state.exprenceLevel,
                                onchanged: (value) {
                                  context
                                      .read<SignInBloc>()
                                      .add(ChangeDropDown(value: value!));
                                },
                              ),
                              const SizedBox(height: 20),
                              //////////////////// Address ////////////////
                              CustomTextField(
                                validate: true,
                                controller: state.address,
                                hint: "${"Address".tr(context)}...",
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
                                          .read<SignInBloc>()
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

                              //////////////////// Sign Up Button ////////////////
                              SizedBox(
                                height: 49,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (state.formKey.currentState
                                            ?.validate() ??
                                        false) {
                                      context.read<SignInBloc>().add(
                                            SignInComplete(),
                                          );
                                    }
                                  },
                                  child: state.isLoading
                                      ? const CircularProgressIndicator(
                                          color:
                                              ThemeColor.loadingIndicatorColor)
                                      : Text(
                                          'SignUpButton'.tr(context),
                                          style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style
                                              ?.textStyle
                                              ?.resolve({}),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              //////////////////// Sign In ////////////////
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "HaveAccount".tr(context),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      letterSpacing: .2,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7F7F7F),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushReplacementNamed(AppRouting.login),
                                    child: Text(
                                      'SignInHere'.tr(context),
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
