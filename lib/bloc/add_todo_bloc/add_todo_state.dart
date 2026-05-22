part of 'add_todo_bloc.dart';

sealed class AddTodoState extends Equatable {
  const AddTodoState();
}

final class AddTodoInitial extends AddTodoState {
  @override
  List<Object> get props => [];
}
