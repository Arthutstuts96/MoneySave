import 'package:intl/intl.dart';

String formatMonetary(double value) {
  final formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );
  return formatter.format(value);
}
