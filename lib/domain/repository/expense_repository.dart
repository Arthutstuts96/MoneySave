import 'package:moneysave/domain/model/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense({required Expense expense}); 
  Future<List<Expense>?> getAllExpenses(); 
  Future<void> editExpense({required Expense newExpense}); 
  Future<void> removeExpense({required String id}); 
  Future<void> deleteAllExpenses();
}
