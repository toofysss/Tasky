import 'package:flutter/material.dart';
import 'package:tasky/Screens/splashscreen.dart';
import '../Screens/qrscan.dart';
import '../Screens/taskdetails.dart';
import '../Screens/home.dart';
import '../Screens/login.dart';
import '../Screens/new_task.dart';
import '../Screens/onboarding.dart';
import '../Screens/profile.dart';
import '../Screens/signup.dart';

class AppRouting {
  static String homepage = "/home";
  static String onBoarding = "/onBoarding";
  static String newTask = "/NewTask";
  static String qrScan = "/qrScan";
  static String taskDetails = "/taskDetails";
  static String login = "/login";
  static String profile = "/Profile";
  static String singIn = "/singIn";
}

final Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => const SplashScreen(),
  AppRouting.onBoarding: (context) => const OnBoarding(),
  AppRouting.newTask: (context) => const NewTask(),
  AppRouting.taskDetails: (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    final iD = arguments?['iD'] as String? ?? "";
    return TaskDetails(iD: iD);
  },
  AppRouting.homepage: (context) => HomePage(),
  AppRouting.qrScan: (context) => const QrScanPage(),
  AppRouting.login: (context) => const Login(),
  AppRouting.profile: (context) => const Profile(),
  AppRouting.singIn: (context) => const SignIn(),
};
