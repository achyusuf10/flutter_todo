import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/app/features/task/domain/entities/todo_entity.dart';

@RoutePage()
class EditTaskPage extends StatefulWidget {
  final TodoEntity selectedTodo;
  const EditTaskPage({super.key, required this.selectedTodo});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
