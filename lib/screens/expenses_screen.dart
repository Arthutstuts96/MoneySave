import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ExpenseController _expenseController = ExpenseController();
  late Future<List<Expense>> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = _expenseController.getAllExpenses();
  }

  Future<void> _getAllExpenses() async {
    setState(() {
      _expenses = _expenseController.getAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await _expenseController.deleteAllExpenses();
              await _getAllExpenses();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getAllExpenses,
        child: FutureBuilder(
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
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: Text('Nenhuma despesa encontrada.'),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: allExpenses.length,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: Text(allExpenses[index].id),
                      );
                    },
                  );
                }
                return const Center(child: Text("Não tem bosta nenhuma"));
            }
          },
        ),
      ),
    );
  }
}
