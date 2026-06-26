import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class UpdateTaskUseCase {
  final TasksRepository _repository;
  UpdateTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(TaskEntity task) =>
      _repository.updateTask(task);
}