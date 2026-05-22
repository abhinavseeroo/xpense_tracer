part of 'list_expenses_cubit.dart';

class ListExpensesState extends Equatable {
  final List<Expense> expenses;

  const ListExpensesState({required this.expenses});

  factory ListExpensesState.initial() {
    return const ListExpensesState(expenses: []);
  }

  @override
  List<Object> get props => [expenses];

  @override
  String toString() => 'ListExpensesState(expenses: $expenses)';

  ListExpensesState copyWith({
    List<Expense>? expenses,
  }) {
    return ListExpensesState(
      expenses: expenses ?? this.expenses,
    );
  }
}
