import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetAllTasksUseCase {
  final TasksRepository _repository;
  GetAllTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call() =>
      _repository.getAllTasks();
}