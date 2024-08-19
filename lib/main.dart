import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vet_app/pages/dogs/dogs.dart';
import 'package:vet_app/pages/home/home_page.dart';
import 'package:vet_app/pages/splashacreen.dart';

import 'pages/cats/cats.dart';
import 'theme/colortheme.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.kanit.toString(),
        elevatedButtonTheme: ThemeColor.buttonTheme,
        colorScheme: ThemeColor.lightTheme,
        textTheme: ThemeColor.fontsTheme,
        useMaterial3: true,
        bottomNavigationBarTheme: ThemeColor.bottomNavigateThemeBar,
      ),
      routes: {
        MyHomePage.homePageRoute: (_) => const MyHomePage(
              title: 'Bem vindo ao Pets App',
            ),
        Cats.catsPageRoute: (_) => const Cats(),
        Dogs.dogsPageRoute: (_) => const Dogs(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SplashScrenn(),
    );
  }
}
