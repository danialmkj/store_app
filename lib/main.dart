import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/common/blocs/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:store_app/common/widgets/main_wrapper.dart';
import 'package:store_app/config/my_theme.dart';
import 'package:store_app/features/feature_auth/presentation/screens/mobile_login_screen.dart';
import 'package:store_app/features/feature_auth/presentation/screens/mobile_signup_screen.dart';
import 'package:store_app/features/feature_home/presentation/screens/home_screen.dart';
import 'package:store_app/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:store_app/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyHttpOverrides global =
      MyHttpOverrides(); //add this line when we occured to error from fetching data in besenior site
  await initLocator(); // add locator
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SplashCubit(),
      ),
      BlocProvider(
        create: (context) => BottomNavCubit(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shopping app',
      home: MobileLoginScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroMainWrapper.routeName: (context) => IntroMainWrapper(),
        MainWrapper.routeName: (context) => MainWrapper(),
        HomeScreen.routeName: (context) => HomeScreen(),
        MobileLoginScreen.routeName : (context) => MobileLoginScreen(),
        MobileSignUpScreen.routeName :(context) => MobileSignUpScreen(),
      },
      supportedLocales: [
        Locale('en', ''),
        Locale('fa', ''),
      ],
      locale: Locale('fa', ''), //default lang
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: ThemeMode.light, //default theme
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
    );
  }
}

//if we occured to error for api from besenior
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
