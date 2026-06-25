class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String status;
  final String assignee;
  final String priority;
  final String dueDate;
  final String projectId;
  final String createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignee,
    required this.priority,
    required this.dueDate,
    required this.projectId,
    required this.createdAt,
  });
}