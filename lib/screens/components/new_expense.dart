import 'package:flutter/material.dart';
import 'package:moneysave/domain/models/expense.dart';
import 'package:uuid/uuid.dart' show Uuid;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSave});

  final void Function(Expense expense) onSave;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _descController = TextEditingController(text: "");
  final _monthsController = TextEditingController();
  final Uuid uuid = Uuid();

  bool _isInInstallments = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _monthsController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        id: uuid.v1(),
        name: _nameController.text,
        value: double.parse(_valueController.text),
        description: _descController.text,
        months: _monthsController.text != ""
            ? int.parse(_monthsController.text)
            : null,
      );
      widget.onSave(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 700,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 14,
          children: [
            SizedBox(height: 6),
            Text(
              "Cadastrar uma nova despesa",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SizedBox(height: 12),

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
                if (value == null || value.isEmpty) {
                  return 'Informe um nome para a despesa';
                }
                return null;
              },
            ),
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
            Checkbox(
              value: _isInInstallments,
              onChanged: (_) {
                setState(() {
                  _isInInstallments = !_isInInstallments;
                  _monthsController.text = "";
                });
              },
            ),
            Visibility(
              visible: _isInInstallments,
              child: TextFormField(
                controller: _monthsController,
                decoration: InputDecoration(
                  labelText: 'Duração (em meses)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.numberWithOptions(),
                // validator: (value) {
                //   if (value == null || value.isEmpty) return null;
                //   final parsed = int.tryParse(value);
                //   if (parsed == null || parsed <= 0) return 'Valor inválido';
                //   return null;
                // },
              ),
            ),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Descreva a despesa (opcional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.abc),
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "";
              //   }
              //   return null;
              // },
            ),
            const SizedBox(height: 16),

            // Submeter formulário
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
