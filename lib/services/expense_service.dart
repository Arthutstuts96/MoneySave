import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneysave/domain/model/expense.dart';

class ExpenseService {
  static const _storageKey = 'expenses';
  final FlutterSecureStorage _storage;

  ExpenseService() : _storage = FlutterSecureStorage();

  Future<List<Expense>> getAllExpenses() async {
    final jsonString = await _storage.read(key: _storageKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Expense.fromJson(e)).toList();
  }

  Future<void> addExpense(Expense expense) async {
    final expenses = await getAllExpenses();
    expenses.add(expense);
    await _saveExpenses(expenses);
  }

  Future<void> updateExpense(Expense updated) async {
    final expenses = await getAllExpenses();
    final index = expenses.indexWhere((e) => e.id == updated.id);
    if (index != -1) {
      expenses[index] = updated;
      await _saveExpenses(expenses);
    }
  }

  Future<void> deleteExpense(String id) async {
    final expenses = await getAllExpenses();
    expenses.removeWhere((e) => e.id == id);
    await _saveExpenses(expenses);
  }

  Future<void> deleteAllExpenses() async {
    await _storage.deleteAll();
  }

  Future<void> _saveExpenses(List<Expense> expenses) async {
    final jsonString = json.encode(expenses.map((e) => e.toJson()).toList());
    await _storage.write(key: _storageKey, value: jsonString);
  }
}
