import 'package:flutter_todo/app/features/task/domain/repositories/task_repository.dart';
import 'package:flutter_todo/core/state/data_state.dart';
import 'package:flutter_todo/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteTodoUc extends UseCase<String, DeleteTodoParams> {
  final TaskRepository taskRepository;

  DeleteTodoUc({required this.taskRepository});

  @override
  Future<DataState<String>> call(DeleteTodoParams params) async {
    return await taskRepository.deleteTodo(
      id: params.id,
    );
  }
}

class DeleteTodoParams {
  final String id;

  DeleteTodoParams({required this.id});
}
