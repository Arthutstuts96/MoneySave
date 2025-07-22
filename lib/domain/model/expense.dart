// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:moneysave/utils/consts.dart';

class Expense {
  String? id;
  double value;
  DateTime? creationDate;
  int? duration;
  bool isActive;
  Priority priority;

  Expense({
    this.id,
    required this.value,
    required this.creationDate,
    this.duration,
    required this.isActive,
    required this.priority,
  });

  Expense copyWith({
    String? id,
    double? value,
    DateTime? creationDate,
    int? duration,
    bool? isActive,
    Priority? priority,
  }) {
    return Expense(
      id: id ?? this.id,
      value: value ?? this.value,
      creationDate: creationDate ?? this.creationDate,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'duration': duration,
      'isActive': isActive,
      'priority': priority.name,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] != null ? map['id'] as String : null,
      value: map['value'] as double,
      creationDate:
          map['creationDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int)
              : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      isActive: map['isActive'] as bool,
      priority: Priority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => Priority.MIN,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, value: $value, creationDate: $creationDate, duration: $duration, isActive: $isActive, priority: $priority)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.value == value &&
        other.creationDate == creationDate &&
        other.duration == duration &&
        other.isActive == isActive &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        value.hashCode ^
        creationDate.hashCode ^
        duration.hashCode ^
        isActive.hashCode ^
        priority.hashCode;
  }
}
