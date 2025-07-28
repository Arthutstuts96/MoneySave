import 'package:moneysave/utils/consts.dart';

String getPriorityLabel(Priority priority) {
  switch (priority) {
    case Priority.IMMEDIATE:
      return 'Imediata';
    case Priority.MAX:
      return 'Alta';
    case Priority.MODERATE:
      return 'Média';
    case Priority.MIN:
      return 'Baixa';
  }
}
