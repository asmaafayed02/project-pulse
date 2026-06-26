import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/task_entity.dart';

abstract interface class TasksRepository {  
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, List<TaskEntity>>> getTasks(String projectId);
  Future<Either<Failure, TaskEntity>>       createTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>>       updateTask(TaskEntity task);
  Future<Either<Failure, void>>             deleteTask(String id);
}