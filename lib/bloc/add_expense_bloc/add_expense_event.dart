part of 'add_expense_bloc.dart';

sealed class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();
}

class NewExpenseAddEvent extends AddExpenseEvent {
  final String amount;
  final String category;
  final String description;

  NewExpenseAddEvent(
      {required this.amount,
      required this.category,
      required this.description});

  @override
  List<Object?> get props => [amount, category, description];

  @override
  String toString() {
    return 'NewExpenseAddEvent(amount: $amount, category: $category, description: $description)';
  }
}

class EditExpenseEvent extends AddExpenseEvent {
  final String id;
  final String amount;
  final String category;
  final String description;

  EditExpenseEvent(
      {required this.id,
      required this.amount,
      required this.category,
      required this.description});

  @override
  List<Object?> get props => [id, amount, category, description];

  @override
  String toString() {
    return 'EditExpenseEvent(id: $id, amount: $amount, category: $category, description: $description)';
  }
}

class RemoveExpenseEvent extends AddExpenseEvent {
  final Expense expense;

  RemoveExpenseEvent({
    required this.expense,
  });

  @override
  List<Object?> get props => [expense];

  @override
  String toString() {
    return 'RemoveExpenseEvent(id: $expense)';
  }
}
class ListExpensesEvent extends AddExpenseEvent {
  const ListExpensesEvent();

  @override
  List<Object?> get props => [];
}