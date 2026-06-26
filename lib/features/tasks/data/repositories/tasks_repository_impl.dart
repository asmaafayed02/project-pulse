import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/core/network/network_error_handler.dart';
import 'package:project_pulse/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:project_pulse/features/tasks/data/models/task_model.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _remote;
  TasksRepositoryImpl(this._remote);
  
@override
Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
  try {
    final result = await _remote.getAllTasks();
    return Right(result);
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) return const Right([]);
      return Left(NetworkErrorHandler.fromDio(e));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
 @override
Future<Either<Failure, List<TaskEntity>>> getTasks(String projectId) async {
  try {
    final result = await _remote.getTasks(projectId);
    return Right(result);
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      return const Right([]); 
    }
      return Left(NetworkErrorHandler.fromDio(e));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

  @override
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task) async {
    try {
      final result = await _remote.createTask(TaskModel.fromEntity(task));
      return Right(result);
     } on DioException catch (e) {
      return Left(NetworkErrorHandler.fromDio(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) async {
    try {
      final result = await _remote.updateTask(TaskModel.fromEntity(task));
      return Right(result);
  } on DioException catch (e) {
      return Left(NetworkErrorHandler.fromDio(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await _remote.deleteTask(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.fromDio(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}