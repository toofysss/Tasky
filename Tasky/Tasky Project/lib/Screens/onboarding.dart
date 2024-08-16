import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../Helpers/applocalization.dart';

import '../blocs/OnBoarding/onboarding_bloc.dart';
import '../constant/asset.dart';
import '../constant/theme.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(context),
      child: BlocBuilder<OnboardingBloc, OnBardingChange>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //////////////////// Image Title ////////////////
                    Expanded(
                      flex: 4,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                          minWidth: 330,
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.onBoarding),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ////////////////////  Title + Dscrp ////////////////
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text("OnBoarding_Title".tr(context),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                  fontSize: 24,
                                  color: ThemeColor.textPrimaryColor,
                                  fontWeight: FontWeight.w700,
                                  height: 1.23)),
                          const SizedBox(height: 5),
                          Text("OnBoarding_Dscrp".tr(context),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: ThemeColor.textSecondaryColor,
                                  fontWeight: FontWeight.w400,
                                  height: 1.23))
                        ],
                      ),
                    ),

                    //////////////////// Button ////////////////
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 331,
                      height: 49,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<OnboardingBloc>()
                              .add(OnBoardingCompleted());
                        },
                        label: Text(
                          "OnBoarding_Button".tr(context),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({}),
                        ),
                        icon: const Icon(
                          HugeIcons.strokeRoundedArrowRight04,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
