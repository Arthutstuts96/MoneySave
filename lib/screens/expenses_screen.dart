import 'package:flutter/material.dart';
import 'package:moneysave/controllers/expense_controller.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/screens/new_expense_screen.dart';
import 'package:moneysave/utils/functions/expiration_date.dart';
import 'package:moneysave/utils/functions/format_monetary.dart';
import 'package:moneysave/utils/functions/page_transition_animate.dart';
import 'package:moneysave/utils/functions/priority_label.dart';

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
      appBar: AppBar(
        title: const Text("Seus gastos"),
        shadowColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Confirmar exclusão'),
                      content: const Text(
                        'Tem certeza que quer deletar todas as despesas? Essa ação não pode ser revertida',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar', style: TextStyle(color: Colors.grey[800]),),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _expenseController.deleteAllExpenses().then((_) {
                              _loadExpenses();
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Deletar', style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    ),
              );
            },
            icon: Icon(Icons.clear, color: Colors.red),
          ),
        ],
      ),
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
                        : ListView.separated(
                          itemCount: allExpenses.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 20,
                              ),
                              child: Divider(),
                            );
                          },
                          itemBuilder: (context, index) {
                            final expense = allExpenses[index];
                            return ListTile(
                              title: Text(
                                '${expense.name}\n${formatMonetary(expense.value)}',
                              ),
                              subtitle: Text(
                                '${getPriorityLabel(expense.priority)} • ${getExpirationDate(expense)}',
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  await _expenseController.removeExpense(
                                    id: expense.id ?? '-1',
                                  );
                                  _loadExpenses();
                                },
                                icon: Icon(Icons.delete_forever),
                                color: Colors.red[700],
                                iconSize: 28,
                              ),
                              leading: Checkbox(
                                value: expense.isActive,
                                onChanged: (value) async {
                                  final Expense newExpense = expense.copyWith(
                                    isActive: !expense.isActive,
                                  );
                                  await _expenseController.editExpense(
                                    newExpense: newExpense,
                                  );
                                  setState(() {
                                    expense.isActive = value!;
                                  });
                                  print(expense);
                                },
                              ),
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
