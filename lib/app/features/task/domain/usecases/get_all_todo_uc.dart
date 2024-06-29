import 'package:flutter_todo/app/features/task/domain/entities/todo_entity.dart';
import 'package:flutter_todo/app/features/task/domain/repositories/task_repository.dart';
import 'package:flutter_todo/core/state/data_state.dart';
import 'package:flutter_todo/core/usecases/no_params_usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllTodoUC extends NoParamsUseCase<List<TodoEntity>> {
  final TaskRepository repository;

  GetAllTodoUC({required this.repository});
  @override
  Future<DataState<List<TodoEntity>>> call() async {
    return await repository.getAllTodo();
  }
}
