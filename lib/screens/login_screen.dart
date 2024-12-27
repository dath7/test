import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  ???
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;dadsasd
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String emailTyped) {
    // regular expression: example@email.vn (not begin with .): test@vais.vn
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9][a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(emailTyped);
  }

  bool isValidPassword(String passwordTyped) {
    // regular expression: 8 digit +:Test1234
    final passwordRegExp = RegExp(r'\S{8,}');
    return passwordRegExp.hasMatch(passwordTyped);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo/vais.jpg"),
                const Text("Welcome back!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    )),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                          ),
                          child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                // label: Text("Email"),
                                icon: Icon(Icons.email_outlined),
                                border: UnderlineInputBorder(),
                                hintText: "Enter your email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (!isValidEmail(value!)) {
                                  return "Enter valid email: example@email.com";
                                }
                                if (value.isEmpty) {
                                  return "Email can't left empty";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.05,
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.grey),
                              // label: const Text("Password"),
                              icon: const Icon(Icons.lock_outline),
                              border: const UnderlineInputBorder(),
                              hintText: "Enter your password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (value) {
                              if (!isValidPassword(value!)) {
                                return "Enter valid password: at least 8 digit";
                              }
                              if (value.isEmpty) {
                                return "Password can't left empty";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * 0.4,
                              bottom: size.height * 0.04),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot password ?",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              showDialog(
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              );

                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .whenComplete(() => Navigator.pop(
                                      context)); // turn off circular process
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Fail to sign in "),
                                    );
                                  });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.lightBlue),
                            padding:
                                MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  horizontal: size.width * 0.39),
                            ),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
