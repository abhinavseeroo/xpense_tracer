part of 'list_expense_bloc.dart';

sealed class ListExpenseEvent extends Equatable {
  const ListExpenseEvent();
}
class ShowExpensesEvent extends ListExpenseEvent {
  final List<Expense> expense;

  ShowExpensesEvent({required this.expense});

  @override

  List<Object?> get props => [expense];
  @override
  String toString() =>
      "ShowExpensesEvent(expense: $expense)";
}