import 'package:flutter_todo/app/features/task/domain/entities/todo_entity.dart';
import 'package:flutter_todo/core/state/data_state.dart';

abstract class TaskRepository {
  Future<DataState<List<TodoEntity>>> getAllTodo();
  Future<DataState<String>> addTodo({
    required TodoEntity todo,
  });
  Future<DataState<String>> updateTodo({
    required TodoEntity todo,
  });
  Future<DataState<String>> deleteTodo({
    required String id,
  });
}
