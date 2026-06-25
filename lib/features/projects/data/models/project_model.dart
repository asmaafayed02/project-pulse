import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.owner,
    required super.priority,
    required super.dueDate,
    required super.createdAt,
  });

  factory ProjectModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      owner: json['owner'] ?? '',
      priority: json['priority'] ?? '',
      dueDate: json['dueDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'owner': owner,
      'priority': priority,
      'dueDate': dueDate,
    };
  }
}