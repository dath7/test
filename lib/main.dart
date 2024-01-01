import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_vais/firebase_options.dart';
import 'package:test_vais/screens/home_screen.dart';
import 'package:test_vais/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (BuildContext context) => const LoginScreen(),
        "/home": (BuildContext context) => HomeScreen(),
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
