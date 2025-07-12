import 'package:flutter/material.dart';
import 'package:moneysave/screens/dashboard.dart';
import 'package:moneysave/screens/login_screen.dart';

void main() {
  runApp(const MoneySave());
}

class MoneySave extends StatelessWidget {
  const MoneySave({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Arial", useMaterial3: true),
      routes: {
        "login_screen": (context) => const LoginScreen(),
        "home_screen": (context) => const Dashboard(),
      },
      initialRoute: "home_screen",
    );
  }
}
