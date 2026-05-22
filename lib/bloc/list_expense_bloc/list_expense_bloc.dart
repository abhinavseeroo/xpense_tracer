import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/expense_model.dart';

part 'list_expense_event.dart';
part 'list_expense_state.dart';

class ListExpenseBloc extends Bloc<ListExpenseEvent, ListExpenseState> {
  ListExpenseBloc() : super(ListExpensesState.initial()) {
    on<ListExpenseEvent>(showExpenses);
  }
  void showExpenses() {
    List<Todo> _filteredTodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos = todoListBloc.state.todos.where((Todo todo) => !todo.isCompleted).toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListBloc.state.todos.where((Todo todo) => todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.todos;
        break;
    }
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }
    add(calculateFilteredTodosEvent(filteredTodos: _filteredTodos));
  }
}
