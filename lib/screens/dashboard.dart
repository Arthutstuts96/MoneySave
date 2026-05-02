import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/models/expense.dart';
import 'package:moneysave/screens/components/new_expense.dart';
import 'package:moneysave/screens/expenses_screen.dart';
import 'package:moneysave/screens/home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ExpenseController _expenseController = ExpenseController();

  int _index = 0;
  List<Expense>? expenses;

  @override
  void initState() {
    super.initState();
    _getAllExpenses();
  }

  void _getAllExpenses() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    List<Expense> allExpenses = await _expenseController.getAllExpenses();

    setState(() {
      expenses = allExpenses;
    });
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money_outlined),
      label: "Despesas",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Conta"),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  void _saveExpense(Expense ex) async {
    await _expenseController.saveExpense(ex);
  }

  final List<Widget> pages = [HomeScreen(), ExpensesScreen(), Placeholder()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      floatingActionButton: FloatingActionButton(
        tooltip: "Cadastrar nova despesa",
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return NewExpense(
                onSave: (newExpense) {
                  _saveExpense(newExpense);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: items,
        onTap: _onPageChanged,
      ),
    );
  }
}
