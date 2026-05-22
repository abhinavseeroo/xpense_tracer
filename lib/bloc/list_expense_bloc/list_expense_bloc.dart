import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/expense_model.dart';
import '../add_expense_bloc/add_expense_bloc.dart';

part 'list_expense_event.dart';
part 'list_expense_state.dart';

class ListExpenseBloc extends Bloc<ListExpenseEvent, ListExpensesState> {
  final AddExpenseBloc addExpenseBloc;
  late final StreamSubscription _addExpenseSubscription;

  ListExpenseBloc({required this.addExpenseBloc})
      : super(ListExpensesState(expenses: addExpenseBloc.state.expenses)) {
    on<ShowExpensesEvent>(_onShowExpenses);

    _addExpenseSubscription = addExpenseBloc.stream.listen((addExpenseState) {
      add(ShowExpensesEvent(expense: addExpenseState.expenses));
    });
  }

  void _onShowExpenses(
      ShowExpensesEvent event, Emitter<ListExpensesState> emit) {
    emit(state.copyWith(expenses: event.expense));
  }

  @override
  Future<void> close() {
    _addExpenseSubscription.cancel();
    return super.close();
  }
}
