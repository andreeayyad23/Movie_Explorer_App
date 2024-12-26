import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_explorer_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer App.',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(surface: Colors.black),
        useMaterial3: true,
        fontFamily: GoogleFonts.ptSans().fontFamily,
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
