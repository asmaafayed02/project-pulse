import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';

class HomeSummary {
  final int projectsCount;
  final int tasksCount;
  final int completedTasks;
  final int inProgressTasks;
  final int pendingTasks;
  final List<ProjectEntity> recentProjects;

  const HomeSummary({
    required this.projectsCount,
    required this.tasksCount,
    required this.completedTasks,
    required this.inProgressTasks,
    required this.pendingTasks,
    required this.recentProjects,
  });

  double get completionRate =>
      tasksCount == 0 ? 0.0 : completedTasks / tasksCount;
}