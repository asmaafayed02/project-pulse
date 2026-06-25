import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/domain/repositories/projects_repository.dart';

class GetProjectsUseCase {
  final ProjectsRepository repository;

  GetProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>>
      call() {
    return repository.getProjects();
  }
}