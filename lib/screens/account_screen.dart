import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Balanço geral")),
      body: Center(child: Text('Sua conta estará aqui')),
    );
  }
}
