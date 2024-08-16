import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/HomePage/home_bloc.dart';
import 'blocs/Task/task_bloc.dart';

import 'Helpers/applocalization.dart';
import 'blocs/Language/language_bloc.dart';
import 'blocs/Logout/logout_bloc.dart';
import 'blocs/Auth/auth_bloc.dart';
import 'constant/routes.dart';
import 'constant/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(context)..add(LoadHomeData()),
        ),
        BlocProvider(
          create: (context) => LocaleBloc()..add(GetSavedLanguage()),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuth()),
        ),
        BlocProvider(
          create: (context) => TaskBloc(context),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(context: context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.watch<LocaleBloc>().state.locale,
      themeMode: ThemeMode.light,
      theme: theme(context),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: appRoutes,
    );
  }
}
