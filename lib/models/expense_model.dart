import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Expense {
  String? amount;
  String? description;
  String? category;
  String id;

  Expense({
    this.amount,
    this.description,
    this.category,
    String? id,
  }) : this.id = id ?? uuid.v4();

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? uuid.v4(),
        amount = json['amount'],
        description = json['description'],
        category = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'category': category,
      'id': id,
    };
  }
}
