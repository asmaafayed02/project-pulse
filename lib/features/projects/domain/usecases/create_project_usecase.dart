import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import '../entities/project_entity.dart';
import '../repositories/projects_repository.dart';

class CreateProjectParams {
  final String title;
  final String description;
  final String status;
  final String priority;
  final String dueDate;

  const CreateProjectParams({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.dueDate,
  });
}

class CreateProjectUseCase {
  final ProjectsRepository _repository;
  CreateProjectUseCase(this._repository);

  Future<Either<Failure, ProjectEntity>> call(CreateProjectParams params) {
    return _repository.createProject(
      title:       params.title,
      description: params.description,
      status:      params.status,
      priority:    params.priority,
      dueDate:     params.dueDate,
    );
  }
}