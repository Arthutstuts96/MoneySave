import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/domain/repository/expense_repository.dart';
import 'package:moneysave/services/expense_service.dart';

class ExpenseController implements ExpenseRepository {
  final ExpenseService _expenseService = ExpenseService();

  @override
  Future<void> addExpense({required Expense expense}) async {
    return await _expenseService.addExpense(expense);
  }

  @override
  Future<void> editExpense({required Expense newExpense}) async {
    return await _expenseService.updateExpense(newExpense);
  }

  @override
  Future<List<Expense>> getAllExpenses() async {
    return await _expenseService.getAllExpenses();
  }

  @override
  Future<void> removeExpense({required String id}) async {
    return await _expenseService.deleteExpense(id);
  }
  
  @override
  Future<void> deleteAllExpenses() async {
    return await _expenseService.deleteAllExpenses();
  }
}
