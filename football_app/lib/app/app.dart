import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:football_app/router/router.dart';
import '../features/colors_view.dart';
import '../home_page/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VLSTATS',
      theme: ThemeData(
        textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.black)),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: MainColors.lightBlue),
        navigationBarTheme:
            NavigationBarThemeData(indicatorColor: MainColors.darkBlue),
        scaffoldBackgroundColor: MainColors.lightBlue,
      ),
      home: const HomePage(),
      routes: routes,
    );
  }
}
