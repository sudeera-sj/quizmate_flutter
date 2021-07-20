import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizmate_flutter/ui/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
        textTheme: GoogleFonts.rubikTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white24,
        textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
      ),
      home: Home(),
    );
  }
}
