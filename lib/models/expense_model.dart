class Expense {
  String? amount;
  String? description;

  Expense({
    this.amount,
    this.description,
  });

  Expense.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
    };
  }
}