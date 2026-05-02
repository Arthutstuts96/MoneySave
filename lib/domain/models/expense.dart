// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expense {
  String id;
  double value;
  String name;
  int? months;
  String description;

  Expense({
    required this.id,
    required this.value,
    required this.name,
    this.months,
    required this.description,
  });

  bool isInInstallments() {
    return months != null;
  }

  Expense copyWith({
    String? id,
    double? value,
    String? name,
    int? months,
    String? description,
  }) {
    return Expense(
      id: id ?? this.id,
      value: value ?? this.value,
      name: name ?? this.name,
      months: months ?? this.months,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'name': name,
      'months': months,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      value: map['value'] as double,
      name: map['name'] as String,
      months: map['months'] != null ? map['months'] as int : null,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, value: $value, name: $name, months: $months, description: $description)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.value == value &&
        other.name == name &&
        other.months == months &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        value.hashCode ^
        name.hashCode ^
        months.hashCode ^
        description.hashCode;
  }
}
