import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseController _expenseController = ExpenseController();
  late Future<List<Expense>?> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = _expenseController.getAllExpenses();
  }

  Future<void> _getAllExpenses() async {
    setState(() {
      _expenses = _expenseController.getAllExpenses();
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bem vindo de volta!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: _getAllExpenses, icon: Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        spacing: 12,
        children: [
          FutureBuilder(
            future: _expenses,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<Expense> allExpenses = snapshot.data!;

                    if (allExpenses.isEmpty) {
                      return Text("R\$ 0,00");
                    }

                    return Center(
                      child: Text(
                        "R\$ ${allExpenses.fold(.0, (previousValue, element) {
                          return previousValue + element.value;
                        })}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "Não tem bosta nenhuma, provavelmente deu erro.",
                    ),
                  );
              }
            },
          ),
          Text("Continua..."),
        ],
      ),
    );
  }
}
