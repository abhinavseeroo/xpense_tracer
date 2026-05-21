import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xpense_tracker/models/expense_model.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseState.initial());

  void addExpense(String amount, String description) {
    final expense = Expense(amount: amount, description: description);
    final expenses = [...state.expenses, expense];
    emit(state.copyWith(expenses: expenses));
    print(state);
  }
}
