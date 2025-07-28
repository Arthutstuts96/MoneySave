import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/screens/components/expense_form_widget.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final ExpenseController _expenseController = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova despesa")),
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Column(
          children: [
            ExpenseFormWidget(
              onSave: (Expense expense) async {
                try {
                  print(expense);
                  await _expenseController.addExpense(expense: expense);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Despesa adicionada com sucesso!"),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(12),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ocorreu um erro: $e"),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(12),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
