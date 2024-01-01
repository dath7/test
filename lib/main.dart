import 'package:flutter/material.dart';
import 'package:test_vais/screens/home_screen.dart';
import 'package:test_vais/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (BuildContext context) => const LoginScreen(),
        "/": (BuildContext context) => HomeScreen(),
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
