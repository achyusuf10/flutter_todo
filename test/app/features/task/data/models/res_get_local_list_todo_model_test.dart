import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/app/features/task/data/models/res_get_local_list_todo_model.dart';

void main() {
  List<TodoModel> listTodo = [
    TodoModel(
      createdAt: DateTime.now().toString(),
      isCompleted: false,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Data 1',
      description: 'Deskripsi Data 1',
      dueDate: '',
    ),
    TodoModel(
      createdAt: DateTime.now().toString(),
      isCompleted: false,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Data 2',
      description: 'Deskripsi Data 2',
      dueDate: DateTime.now().toString(),
    ),
    TodoModel(
      createdAt: DateTime.now().toString(),
      isCompleted: false,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Data 3',
      description: 'Deskripsi Data 3',
      dueDate: '',
    ),
  ];
  group(
    'Json Function Test',
    () {
      test(
        'should return a valid model',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              ResGetLocalListTodoModel(data: listTodo).toJson();
          // act
          final result = ResGetLocalListTodoModel.fromJson(jsonMap);
          // assert
          expect(result, isA<ResGetLocalListTodoModel>());
        },
      );

      test(
        'should return a valid json',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              ResGetLocalListTodoModel(data: listTodo).toJson();
          // act
          final data = ResGetLocalListTodoModel.fromJson(jsonMap);
          final result = data.toJson();

          // assert
          final expectedMap = jsonMap;
          expect(expectedMap, result);
        },
      );
    },
  );
}
