import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense_tracker/cubits/add_expense/add_expense_cubit.dart';
import 'package:xpense_tracker/models/expense_model.dart';

part 'list_expenses_state.dart';

class ListExpensesCubit extends Cubit<ListExpensesState> {
  final AddExpenseCubit addExpenseCubit;
  late final StreamSubscription addExpenseSubscription;

  ListExpensesCubit({required this.addExpenseCubit})
      : super(ListExpensesState(expenses: addExpenseCubit.state.expenses)) {
    addExpenseSubscription = addExpenseCubit.stream.listen((addExpenseState) {
      emit(state.copyWith(expenses: addExpenseState.expenses));
    });
  }

  @override
  Future<void> close() {
    addExpenseSubscription.cancel();
    return super.close();
  }
}
