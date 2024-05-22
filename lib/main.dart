import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberto_mobile/pages/home_page/home_page.dart';

void main() {
  runApp(const HabertoApp());
}

class HabertoApp extends StatelessWidget {
  const HabertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
