import 'package:moneysave/domain/model/expense.dart';

String getExpirationDate(Expense expense) {
  if (expense.creationDate == null || expense.duration == null) {
    return 'Data ou duração indefinida';
  }

  final expirationDate = DateTime(
    expense.creationDate!.year,
    expense.creationDate!.month + expense.duration!,
    expense.creationDate!.day,
  );

  final now = DateTime.now();
  final diffMonths =
      (expirationDate.year - now.year) * 12 +
      (expirationDate.month - now.month);

  if (diffMonths <= 0) return 'Expirada';
  return 'Expira em $diffMonths ${diffMonths == 1 ? 'mês' : 'meses'}';
}
