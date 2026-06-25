import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.assignee,
    required super.priority,
    required super.dueDate,
    required super.projectId,
    required super.createdAt,
  });

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      assignee: json['assignee'] ?? '',
      priority: json['priority'] ?? '',
      dueDate: json['dueDate'] ?? '',
      projectId: json['projectId'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'assignee': assignee,
      'priority': priority,
      'dueDate': dueDate,
      'projectId': projectId,
    };
  }
}