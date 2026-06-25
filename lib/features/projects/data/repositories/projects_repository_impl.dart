import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/features/projects/data/datasources/projects_remote_datasource.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl
    implements ProjectsRepository {
  final ProjectsRemoteDataSource remote;

  ProjectsRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ProjectEntity>>>
      getProjects() async {
    try {
      final result =
          await remote.getProjects();

      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
  @override
  Future<Either<Failure, ProjectEntity>> createProject({  
    required String title,
    required String description,
    required String status,
    required String priority,
    required String dueDate,
  }) async {
    try {
      final result = await remote.createProject(
        title:       title,
        description: description,
        status:      status,
        priority:    priority,
        dueDate:     dueDate,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}