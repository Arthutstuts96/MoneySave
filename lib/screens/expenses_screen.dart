import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/screens/new_expense_screen.dart';
import 'package:moneysave/utils/functions/page_transition_animate.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ExpenseController _expenseController = ExpenseController();
  List<Expense> allExpenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final List<Expense> response = await _expenseController.getAllExpenses();
    setState(() {
      allExpenses = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seus gastos")),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _loadExpenses,
                child:
                    allExpenses.isEmpty
                        ? ListView(
                          children: [
                            SizedBox(height: 100),
                            Center(child: Text("Nenhuma despesa encontrada.")),
                          ],
                        )
                        : ListView.builder(
                          itemCount: allExpenses.length,
                          itemBuilder: (context, index) {
                            final expense = allExpenses[index];
                            return ListTile(
                              title: Text(
                                "R\$ ${expense.value.toStringAsFixed(2)}",
                              ),
                              subtitle: Text(expense.priority.name),
                            );
                          },
                        ),
              ),
      floatingActionButton: SizedBox(
        width: 160,
        height: 52,
        child: FloatingActionButton(
          backgroundColor: Colors.red[200],
          onPressed: () async {
            await Navigator.push(
              context,
              navigateUsingTransitionFromBelow(NewExpenseScreen()),
            );
            _loadExpenses(); // recarrega ao voltar da tela
          },
          child: const ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              size: 30,
              color: Colors.green,
            ),
            title: Text("Adicionar"),
          ),
        ),
      ),
    );
  }
}
