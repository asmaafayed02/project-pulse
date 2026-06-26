import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/features/home/domain/entities/home_summary_entity.dart';
import 'package:project_pulse/features/home/presentation/providers/home_dependencies.dart';
import 'package:project_pulse/features/projects/domain/usecases/get_projects_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/get_all_tasks_usecase.dart';

class HomeNotifier extends AsyncNotifier<HomeSummary> {
  late final GetProjectsUseCase _getProjectsUseCase;
  late final GetAllTasksUseCase _getAllTasksUseCase;

  @override
  Future<HomeSummary> build() async {
    _getProjectsUseCase = ref.read(getProjectsUseCaseProvider);
    _getAllTasksUseCase = ref.read(getAllTasksUseCaseProvider);

    final projectsResult = await _getProjectsUseCase();
    final tasksResult = await _getAllTasksUseCase();

    return projectsResult.fold(
      (failure) => throw failure,
      (projects) {
        return tasksResult.fold(
          (failure) => throw failure,
          (tasks) {
            final completedTasks =
                tasks.where((t) => t.isDone).length;

            final inProgressTasks =
                tasks.where((t) => t.isInProgress).length;

            final pendingTasks =
                tasks.where((t) => t.isPending).length;

            final recent = [...projects]
              ..sort((a, b) {
                int rank(String s) => switch (s.toLowerCase()) {
                      'active' || 'in progress' => 0,
                      'planning' || 'pending' => 1,
                      _ => 2,
                    };

                return rank(a.status)
                    .compareTo(rank(b.status));
              });

            return HomeSummary(
              projectsCount: projects.length,
              tasksCount: tasks.length,
              completedTasks: completedTasks,
              inProgressTasks: inProgressTasks,
              pendingTasks: pendingTasks,
              recentProjects: recent.take(4).toList(),
            );
          },
        );
      },
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}