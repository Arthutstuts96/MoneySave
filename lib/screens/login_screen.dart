import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Text("Bem vindo ao MoneySave!", textAlign: TextAlign.center, style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 40,

            ),),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "home_screen");
              },
              label: Text("Entrar"),
              icon: Icon(Icons.attach_money_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
