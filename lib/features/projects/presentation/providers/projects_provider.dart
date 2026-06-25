import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:project_pulse/features/projects/presentation/providers/projects_dependencies.dart';

import '../../domain/usecases/get_projects_usecase.dart';

class ProjectsNotifier
    extends StateNotifier<AsyncValue<List<ProjectEntity>>> {
  final GetProjectsUseCase _getProjectsUseCase;
  final CreateProjectUseCase _createProjectUseCase;
  ProjectsNotifier(
    this._getProjectsUseCase,
    this._createProjectUseCase,
  ) : super(const AsyncLoading()) {
    loadProjects();
  }

  Future<void> loadProjects() async {
    state = const AsyncLoading();

    final result = await _getProjectsUseCase();

    result.fold(
      (failure) {
        state = AsyncError(
          failure.message,
          StackTrace.current,
        );
      },
      (projects) {
        state = AsyncData(projects);
      },
    );
  }

  Future<void> refresh() async {
    await loadProjects();
  }

  // ── Create ───────────────────────────────────────
  Future<void> createProject({
    required String title,
    required String description,
    required String status,
    required String priority,
    required String dueDate,
  }) async {
    final result = await _createProjectUseCase(
      CreateProjectParams(
        title:       title,
        description: description,
        status:      status,
        priority:    priority,
        dueDate:     dueDate,
      ),
    );

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (newProject) {
        final current = state.value ?? [];
        state = AsyncData([newProject, ...current]);
      },
    );
  }

}

final projectsProvider = StateNotifierProvider<
    ProjectsNotifier,
    AsyncValue<List<ProjectEntity>>>(
  (ref) => ProjectsNotifier(
    ref.read(getProjectsUseCaseProvider),
    ref.read(createProjectUseCaseProvider),
  ),
);