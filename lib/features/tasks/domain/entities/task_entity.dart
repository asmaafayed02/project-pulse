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

String get normalizedStatus =>
    status.trim().toLowerCase();

bool get isPending => normalizedStatus == 'pending';

bool get isInProgress =>
    normalizedStatus == 'in progress';

bool get isDone => normalizedStatus == 'done';


  TaskEntity copyWith({String? status}) {
    return TaskEntity(
      id:          id,
      title:       title,
      description: description,
      status:      status ?? this.status,
      assignee:    assignee,
      priority:    priority,
      dueDate:     dueDate,
      projectId:   projectId,
      createdAt:   createdAt,
    );
  }
}