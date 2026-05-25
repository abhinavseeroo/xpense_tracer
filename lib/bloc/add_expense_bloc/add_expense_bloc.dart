import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/expense_model.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc() : super(AddExpenseState.initial()) {
    on<ListExpensesEvent>(listExpenses);
    on<NewExpenseAddEvent>(addExpense);
    on<EditExpenseEvent>(editExpense);
    on<RemoveExpenseEvent>(removeExpense);
  }
  void listExpenses(ListExpensesEvent event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(expenses: state.expenses));
  }
  void addExpense(NewExpenseAddEvent event, Emitter<AddExpenseState> emit) {
    final expenses = Expense(
        amount: event.amount,
        category: event.category,
        description: event.description);
    final newExpenses = [...state.expenses, expenses];
    emit(state.copyWith(expenses: newExpenses));
    print(state);
  }

  void editExpense(EditExpenseEvent event, Emitter<AddExpenseState> emit) {
    final editExpenses = state.expenses.map((expense) {
      if (expense.id == event.id) {
        return Expense(
            id: event.id,
            description: event.description,
            amount: event.amount,
            category: event.category);
      }
      return expense;
    }).toList();
    emit(state.copyWith(expenses: editExpenses));
    print(state);
  }

  void removeExpense(RemoveExpenseEvent event, Emitter<AddExpenseState> emit) {
    final editExpenses = state.expenses
        .where((element) => element.id != event.expense.id)
        .toList();
    emit(state.copyWith(expenses: editExpenses));
    print(state);
  }
}
