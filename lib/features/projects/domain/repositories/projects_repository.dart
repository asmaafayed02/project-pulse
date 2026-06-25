import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>>
      getProjects();

   Future<Either<Failure, ProjectEntity>> createProject({  
    required String title,
    required String description,
    required String status,
    required String priority,
    required String dueDate,
  });
}