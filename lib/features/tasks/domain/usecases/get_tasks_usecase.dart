import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetTasksUseCase {
  final TasksRepository _repository;
  GetTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call(String projectId) =>
      _repository.getTasks(projectId);
}