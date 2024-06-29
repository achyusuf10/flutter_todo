// ignore_for_file: unused_element

import 'package:flutter_todo/app/features/task/data/models/res_get_local_list_todo_model.dart';
import 'package:flutter_todo/config/source_config/local/hive_config.dart';
import 'package:flutter_todo/constants/core/hive_key_const.dart';
import 'package:flutter_todo/core/loggers/app_logger.dart';
import 'package:flutter_todo/core/state/data_state.dart';
import 'package:injectable/injectable.dart';

abstract class TaskLocalDataSource {
  Future<DataState<ResGetLocalListTodoModel>> getAllListTodo();
  Future<DataState<String>> addTodo({
    required TodoModel todo,
  });

  Future<DataState<String>> updateTodo({
    required String id,
    required String title,
    required String description,
    required DateTime? dueDate,
    required bool isCompleted,
  });

  Future<DataState<String>> deleteTodo({
    required String id,
  });

  Future<DataState<String>> deleteAllTodo();

  Future<DataState<String>> saveAllData({
    required List<TodoModel> listData,
  });
}

@LazySingleton(as: TaskLocalDataSource)
class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  final HiveConfig _hive;

  TaskLocalDataSourceImpl({required HiveConfig hive}) : _hive = hive;

  @override
  Future<DataState<String>> addTodo({required TodoModel todo}) async {
    try {
      var resListData = await getAllListTodo();
      return resListData.map(
        success: (mapSuccess) {
          List<TodoModel> listData = List.from(mapSuccess.data.data);
          listData.add(todo);
          return saveAllData(listData: listData);
        },
        error: (mapError) {
          return DataState.error(
            message: mapError.message,
            exception: mapError.exception,
            stackTrace: mapError.stackTrace,
          );
        },
      );
    } catch (e, stackTrace) {
      return DataState.error(
        message: 'Error Add Todo',
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DataState<String>> deleteAllTodo() async {
    try {
      await _hive.delete(HiveKeyConst.listTodoKey);
      return const DataState.success(data: 'Success');
    } catch (e, stackTrace) {
      return DataState.error(
        message: 'Error Delete All Todo',
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DataState<String>> deleteTodo({required String id}) async {
    try {
      var resListData = await getAllListTodo();
      return resListData.map(
        success: (mapSuccess) {
          List<TodoModel> listData = List.from(mapSuccess.data.data);
          int index = listData.indexWhere((element) => element.id == id);
          if (index == -1) throw ('Data Todo Not Found');
          listData.removeWhere((element) => element.id == id);
          return saveAllData(listData: listData);
        },
        error: (mapError) {
          return DataState.error(
            message: mapError.message,
            exception: mapError.exception,
            stackTrace: mapError.stackTrace,
          );
        },
      );
    } catch (e, stackTrace) {
      return DataState.error(
        message: 'Error Delete Todo',
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DataState<ResGetLocalListTodoModel>> getAllListTodo() async {
    try {
      var resData = await _hive.get(key: HiveKeyConst.listTodoKey);
      if (resData == null) {
        return DataState.success(
          data: ResGetLocalListTodoModel(
            data: [],
          ),
        );
      }
      var modelResData =
          ResGetLocalListTodoModel.fromJson(resData as Map<dynamic, dynamic>);
      return DataState.success(data: modelResData);
    } catch (e, stackTrace) {
      AppLogger.logError(e.toString(),
          runtimeType: runtimeType, stackTrace: stackTrace);
      return DataState.error(
        message: e.toString(),
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DataState<String>> updateTodo({
    required String id,
    required String title,
    required String description,
    required DateTime? dueDate,
    required bool isCompleted,
  }) async {
    try {
      var resListData = await getAllListTodo();
      return resListData.map(
        success: (mapSuccess) {
          List<TodoModel> listData = List.from(mapSuccess.data.data);
          int index = listData.indexWhere((element) => element.id == id);
          if (index == -1) throw ('Data Todo Not Found');
          listData[index] = listData[index].copyWith(
            title: title,
            description: description,
            dueDate: dueDate == null ? '' : dueDate.toString(),
            isCompleted: isCompleted,
          );
          return saveAllData(listData: listData);
        },
        error: (mapError) {
          return DataState.error(
            message: mapError.message,
            exception: mapError.exception,
            stackTrace: mapError.stackTrace,
          );
        },
      );
    } catch (e, stackTrace) {
      return DataState.error(
        message: 'Error Update Todo',
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DataState<String>> saveAllData({
    required List<TodoModel> listData,
  }) async {
    try {
      var res = ResGetLocalListTodoModel(data: listData);
      await _hive.set(key: HiveKeyConst.listTodoKey, data: res.toJson());
      return const DataState.success(data: 'Success');
    } catch (e, stackTrace) {
      return DataState.error(
        message: 'Error Save All Todo',
        exception: Exception(e),
        stackTrace: stackTrace,
      );
    }
  }
}


    // try {
    //   /// * Todo : Add Function
    // } catch (e, stackTrace) {
    //   return DataState.error(
    //     message: 'Error Add Todo',
    //     exception: Exception(e),
    //     stackTrace: stackTrace,
    //   );
    // }