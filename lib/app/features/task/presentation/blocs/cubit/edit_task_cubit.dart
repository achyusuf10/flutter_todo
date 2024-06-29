import 'package:bloc/bloc.dart';
import 'package:flutter_todo/app/features/task/domain/entities/todo_entity.dart';
import 'package:flutter_todo/utils/functions/get_context_func.dart';
import 'package:flutter_todo/utils/services/dialog_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_task_cubit.freezed.dart';
part 'edit_task_state.dart';

@lazySingleton
class EditTaskCubit extends Cubit<EditTaskState> {
  final DialogService _dialogService;
  final GetContextFunc _context;
  EditTaskCubit(this._dialogService, this._context)
      : super(const EditTaskState());

  void init(TodoEntity todo) {
    emit(state.copyWith(selectedTodo: todo));
  }
}
