import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/app/features/task/data/datasources/local/task_local_datasource.dart';
import 'package:flutter_todo/app/features/task/data/models/res_get_local_list_todo_model.dart';
import 'package:flutter_todo/config/source_config/local/hive_config_impl.dart';
import 'package:flutter_todo/constants/core/hive_key_const.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HiveConfigImpl>()])
void main() {
  late TaskLocalDataSource taskLocalDataSource;
  late MockHiveConfigImpl hive;

  List<TodoModel> listTodo = [
    TodoModel(
      createdAt: DateTime.now().toString(),
      isCompleted: false,
      id: 'id-1',
      title: 'Data 1',
      description: 'Deskripsi Data 1',
      dueDate: '',
    ),
  ];

  var resTodoModel = ResGetLocalListTodoModel(data: listTodo);
  var resTodoMap = resTodoModel.toJson();

  setUp(() {
    hive = MockHiveConfigImpl();
    taskLocalDataSource = TaskLocalDataSourceImpl(hive: hive);
  });

  group(
    'Add Todo Test',
    () {
      test(
        'Should Add Func Return Success',
        () async {
          /// * Arrange
          when(
            hive.get(
              key: HiveKeyConst.listTodoKey,
            ),
          ).thenAnswer(
            (_) async => resTodoMap,
          );

          when(
            hive.set(
              key: HiveKeyConst.listTodoKey,
              data: resTodoMap,
            ),
          ).thenAnswer(
            (_) async => true,
          );

          ///*  Act
          var result = await taskLocalDataSource.addTodo(
            todo: listTodo[0],
          );

          ///* Assert
          var data = result.whenOrNull(
            success: (data) => data,
            error: (message, exception, stackTrace) {
              return exception.toString();
            },
          );
          expect(
            data,
            'Success',
          );
        },
      );
    },
  );

  group(
    'Delete A Todo Test',
    () {
      test(
        'Should Delete Func Return Success',
        () async {
          /// * Arrange
          when(
            hive.get(
              key: HiveKeyConst.listTodoKey,
            ),
          ).thenAnswer(
            (_) async => resTodoMap,
          );

          when(
            hive.set(
              key: HiveKeyConst.listTodoKey,
              data: resTodoMap,
            ),
          ).thenAnswer(
            (_) async => true,
          );

          ///*  Act
          var result = await taskLocalDataSource.deleteTodo(id: 'id-1');

          ///* Assert
          var data = result.whenOrNull(
            success: (data) => data,
            error: (message, exception, stackTrace) {
              return exception.toString();
            },
          );
          expect(
            data,
            'Success',
          );
        },
      );
    },
  );

  group(
    'Update Todo Test',
    () {
      test(
        'Should Update Func Return Success',
        () async {
          /// * Arrange
          when(
            hive.get(
              key: HiveKeyConst.listTodoKey,
            ),
          ).thenAnswer(
            (_) async => resTodoMap,
          );

          when(
            hive.set(
              key: HiveKeyConst.listTodoKey,
              data: resTodoMap,
            ),
          ).thenAnswer(
            (_) async => true,
          );

          ///*  Act
          var result = await taskLocalDataSource.updateTodo(
            id: listTodo.first.id,
            title: 'Title Baru',
            description: 'Desc Baru',
            dueDate: DateTime.now().add(const Duration(days: 1)),
            isCompleted: true,
          );

          ///* Assert
          var data = result.whenOrNull(
            success: (data) => data,
            error: (message, exception, stackTrace) {
              return exception.toString();
            },
          );
          expect(
            data,
            'Success',
          );
        },
      );
    },
  );
}
