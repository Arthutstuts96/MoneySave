import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense, required this.onDelete});
  final Expense expense;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onDoubleTap: () async {
          if (expense.months != null && expense.months! > 1) {
            await ExpenseController().editExpense(
              expense.copyWith(months: expense.months! - 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "O mês da despesa ${expense.name} foi diminuído em 1!",
                ),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        child: ListTile(
          title: Text(expense.name),
          subtitle: Text(
            expense.months != null
                ? 'R\$${expense.value * expense.months!}  • Vence em ${expense.months} meses'
                : 'R\$${expense.value}',
          ),
          leading: Icon(Icons.abc),
          trailing: IconButton(
            onPressed: () {
              onDelete(expense.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("A despesa foi removida!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
