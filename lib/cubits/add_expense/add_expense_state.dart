part of 'add_expense_cubit.dart';

class AddExpenseState extends Equatable {
  final List<Expense> expenses;

  const AddExpenseState({required this.expenses});

  factory AddExpenseState.initial() {
    return const AddExpenseState(expenses: []);
  }

  @override
  List<Object> get props => [expenses];

  @override
  String toString() => 'AddExpenseState(expenses: $expenses)';

  AddExpenseState copyWith({List<Expense>? expenses}) {
    return AddExpenseState(
      expenses: expenses ?? this.expenses,
    );
  }
}
