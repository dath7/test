import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_vais/firebase_options.dart';
import 'package:test_vais/providers/users_provider.dart';
import 'package:test_vais/screens/home_screen.dart';
import 'package:test_vais/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStatus = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   "/home": (BuildContext context) => HomeScreen(),
      // },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: userStatus.when(
        data: (user) {
          return (user == null) ? const LoginScreen() : HomeScreen();
        },
        error: (error, stackTrace) {
          return const Center(child: Text("Something went wrong.."));
        },
        loading: () {
          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }
}
