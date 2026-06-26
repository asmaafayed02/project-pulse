import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class CreateTaskParams {
  final String title;
  final String description;
  final String status;
  final String priority;
  final String dueDate;
  final String projectId;
  final String assignee;

  const CreateTaskParams({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.projectId,
    required this.assignee,
  });
}

class CreateTaskUseCase {
  final TasksRepository _repository;
  CreateTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(CreateTaskParams params) =>
      _repository.createTask(
        TaskEntity(
          id:          '',
          title:       params.title,
          description: params.description,
          status:      params.status,
          priority:    params.priority,
          dueDate:     params.dueDate,
          projectId:   params.projectId,
          assignee:    params.assignee,
          createdAt:   DateTime.now().toIso8601String(),
        ),
      );
}