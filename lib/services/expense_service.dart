import 'dart:convert';
import 'package:moneysave/domain/models/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  final String _key = "expense";

  Future<void> _saveAll(List<Expense> expenses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> stringList = expenses.map((expense) {
      // CORREÇÃO 1: Simetria.
      // Se você lê usando fromMap(), o ideal é salvar convertendo de toMap().
      // Se o seu modelo Expense não tiver um toMap(), e o toJson() dele
      // já retornar uma String, mude esta linha apenas para: return expense.toJson();
      return jsonEncode(expense.toMap());
    }).toList();

    await prefs.setStringList(_key, stringList);
  }

  Future<void> saveExpense(Expense expense) async {
    List<Expense> allExpenses = await getAllExpenses();
    allExpenses.add(expense);
    await _saveAll(allExpenses);
  }

  Future<void> editExpense(Expense newExpense) async {
    List<Expense> allExpenses = await getAllExpenses();
    int position = allExpenses.indexWhere((e) => e.id == newExpense.id);

    if (position != -1) {
      allExpenses[position] = newExpense;
      await _saveAll(allExpenses);
    }
  }

  Future<List<Expense>> getAllExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? listString = prefs.getStringList(_key);

    List<Expense> expenses = [];

    if (listString != null) {
      for (var ex in listString) {
        try {
          // Faz o decode da String
          final dynamic decoded = jsonDecode(ex);

          // CORREÇÃO 2: Verificação de segurança
          // Só tenta converter se o resultado for realmente um Map
          if (decoded is Map<String, dynamic>) {
            expenses.add(Expense.fromMap(decoded));
          } else if (decoded is String) {
            // Se cair aqui, é porque o dado salvo no aparelho sofreu duplo encoding
            // Opcional: tentar fazer um segundo jsonDecode(decoded) para salvar o dado antigo
            final Map<String, dynamic> doubleDecoded = jsonDecode(decoded);
            expenses.add(Expense.fromMap(doubleDecoded));
          }
        } catch (e) {
          // Ignora itens mal formatados que possam ter ficado salvos com erro no passado
          print("Erro ao ler a despesa: $e");
        }
      }
    }
    return expenses;
  }

  Future<void> deleteExpense(String id) async {
    List<Expense> allExpenses = await getAllExpenses();
    allExpenses.removeWhere((element) => element.id == id);
    await _saveAll(allExpenses);
  }

  Future<bool> deleteAllExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_key);
  }
}
