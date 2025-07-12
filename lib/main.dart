import 'package:flutter/material.dart';

void main() {
  runApp(const MoneySave());
}

class MoneySave extends StatelessWidget {
  const MoneySave({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('John Doe!'),
        ),
      ),
    );
  }
}
