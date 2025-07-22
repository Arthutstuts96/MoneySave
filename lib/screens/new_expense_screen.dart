import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/utils/consts.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  Expense _newExpense = Expense(
    value: .0,
    creationDate: null,
    isActive: false,
    priority: Priority.MIN,
  );
  final ExpenseController _expenseController = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova despesa")),
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Column(
          children: [
            FormField(
              builder: (field) {
                return TextFormField();
              },
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 56, horizontal: 24),
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    print(_newExpense);
                    await _expenseController.addExpense(expense: _newExpense);
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
                child: Text("Enviar"),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
