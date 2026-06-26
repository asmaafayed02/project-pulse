import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/features/projects/domain/usecases/get_projects_usecase.dart';
import 'package:project_pulse/features/projects/presentation/providers/projects_dependencies.dart';
import 'package:project_pulse/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:project_pulse/features/tasks/presentation/providers/tasks_provider.dart';


final getProjectsUseCaseProvider =
    Provider<GetProjectsUseCase>((ref) {
  return GetProjectsUseCase(
    ref.read(projectsRepositoryProvider),
  );
});

final getAllTasksUseCaseProvider =
    Provider<GetAllTasksUseCase>((ref) {
  return GetAllTasksUseCase(
    ref.read(tasksRepositoryProvider),
  );
});