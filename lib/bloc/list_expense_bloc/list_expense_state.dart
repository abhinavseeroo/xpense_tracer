part of 'list_expense_bloc.dart';

sealed class ListExpenseState extends Equatable {
  const ListExpenseState();
}

final class ListExpenseInitial extends ListExpenseState {
  @override
  List<Object> get props => [];
}
