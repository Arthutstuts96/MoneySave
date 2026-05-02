import 'package:moneysave/domain/models/expense.dart';
import 'package:moneysave/services/expense_service.dart';

class ExpenseController {
  final ExpenseService _expenseService = ExpenseService();

  Future<List<Expense>> getAllExpenses() async {
    return await _expenseService.getAllExpenses();
  }

  Future<void> saveExpense(Expense expense) async {
    return await _expenseService.saveExpense(expense);
  }

  Future<void> editExpense(Expense expense) async {
    return await _expenseService.editExpense(expense);
  }

  Future<void> deleteExpense(String id) async {
    return await _expenseService.deleteExpense(id);
  }

  Future<void> deleteAllExpenses() async {
    await _expenseService.deleteAllExpenses();
  }
}
