import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_expense_event.dart';
part 'list_expense_state.dart';

class ListExpenseBloc extends Bloc<ListExpenseEvent, ListExpenseState> {
  ListExpenseBloc() : super(ListExpenseInitial()) {
    on<ListExpenseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
