class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final String status;
  final String owner;
  final String priority;
  final String dueDate;
  final String createdAt;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.owner,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
  });
}