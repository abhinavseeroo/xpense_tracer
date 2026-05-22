import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoBloc() : super(AddTodoInitial()) {
    on<AddTodoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
