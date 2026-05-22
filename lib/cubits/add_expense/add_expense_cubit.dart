import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense_tracker/models/expense_model.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseState.initial());

  void addExpense(String amount, String description, String category) {
    final expense =
        Expense(amount: amount, description: description, category: category);
    final expenses = [...state.expenses, expense];
    emit(state.copyWith(expenses: expenses));
  }

  void editExpense(
      String id, String amount, String description, String category) {
    final expense = state.expenses.map((expense) {
      if (expense.id == id) {
        return Expense(
            id: id,
            amount: amount,
            description: description,
            category: category);
      }
      return expense;
    }).toList();
    emit(state.copyWith(expenses: expense));
  }

  void removeExpense(Expense expense) {
    final updatedExpense =
        state.expenses.where((element) => element.id != expense.id).toList();
    emit(state.copyWith(expenses: updatedExpense));
  }
}
