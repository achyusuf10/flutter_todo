class TodoEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;

  TodoEntity({
    required this.id,
    this.dueDate,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
