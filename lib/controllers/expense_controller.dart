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
  Future<bool> editExpense({required Expense newExpense}) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> getAllExpenses() async {
    return await _expenseService.getAllExpenses();
  }

  @override
  Future<bool> removeExpense({required String id}) {
    // TODO: implement removeExpense
    throw UnimplementedError();
  }
}
