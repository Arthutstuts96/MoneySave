import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/utils/functions/format_monetary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseController _expenseController = ExpenseController();
  late final List<Expense> allExpenses;
  bool cashVisible = false;
  double totalValue = .0;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final List<Expense> response = await _expenseController.getAllExpenses();
    double newTotalValue = 0;
    for (Expense ex in response) {
      if (ex.isActive) {
        newTotalValue += ex.value;
      }
    }
    setState(() {
      allExpenses = response;
      totalValue = newTotalValue;
    });
  }

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
                    Text("Aqui está o balanço atual das suas despesas:"),
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
                            formatMonetary(totalValue),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cashVisible = !cashVisible;
                            });
                          },
                          icon: Icon(
                            cashVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded,
                          ),
                        ),
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
