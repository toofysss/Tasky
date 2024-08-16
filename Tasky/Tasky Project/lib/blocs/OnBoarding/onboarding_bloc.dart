import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/onboardinghelper.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnBardingChange> {
  BuildContext context;
  OnboardingBloc(this.context) : super(OnBardingChange(change: false)) {
    //////////////////// Skip OnBoarding ////////////////

    on<OnboardingEvent>((event, emit) async {
      if (event is OnBoardingCompleted) {
        await OnBoardingHelper.setAuth(context);
      }
    });
  }
}
