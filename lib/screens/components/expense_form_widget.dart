import 'package:flutter/material.dart';
import 'package:moneysave/domain/model/expense.dart';
import 'package:moneysave/utils/consts.dart';
import 'package:moneysave/utils/functions/priority_label.dart';
import 'package:uuid/uuid.dart';

class ExpenseFormWidget extends StatefulWidget {
  final void Function(Expense expense) onSave;
  const ExpenseFormWidget({super.key, required this.onSave});

  @override
  State<ExpenseFormWidget> createState() => _ExpenseFormWidgetState();
}

class _ExpenseFormWidgetState extends State<ExpenseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  Priority _selectedPriority = Priority.MIN;
  var uuid = Uuid();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        id: uuid.v1(),
        name: _nameController.text,
        duration: int.parse(_durationController.text),
        value: double.parse(_valueController.text),
        creationDate: DateTime.now(),
        isActive: true,
        priority: _selectedPriority,
      );
      widget.onSave(newExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome da despesa
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da despesa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.abc),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Informe um nome para a despesa';
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Valor
            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Informe um valor';
                final parsed = double.tryParse(value);
                if (parsed == null || parsed <= 0) return 'Valor inválido';
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Duração
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duração (em meses)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.timer),
              ),
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Informe um valor';
                final parsed = int.tryParse(value);
                if (parsed == null || parsed <= 0) return 'Valor inválido';
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Prioridade
            DropdownButtonFormField<Priority>(
              value: _selectedPriority,
              items:
                  Priority.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(getPriorityLabel(priority)),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPriority = value);
                }
              },
              decoration: InputDecoration(
                labelText: 'Prioridade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.priority_high),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(Icons.save),
                label: Text('Salvar despesa'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
