import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/config/my_theme.dart';
import 'package:store_app/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:store_app/features/feature_intro/presentation/screens/home_screen.dart';
import 'package:store_app/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SplashCubit(),
      ),
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
      initialRoute: '/',
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroMainWrapper.routeName: (context) => IntroMainWrapper(),
        HomeScreen.routeName: (context)=> HomeScreen(),
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
