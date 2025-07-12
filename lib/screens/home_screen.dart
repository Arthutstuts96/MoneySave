import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool cashVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olá, usuário!")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4, 4),
                      spreadRadius: 4,
                      blurRadius: 4,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    Text("Aqui está o balanço atual das suas finanças:"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: cashVisible,
                          replacement: Text(
                            "R\$ •••••••.••",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          child: Text(
                            "R\$ 5.405,54",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            cashVisible = !cashVisible;
                          });
                        }, icon: Icon(cashVisible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
