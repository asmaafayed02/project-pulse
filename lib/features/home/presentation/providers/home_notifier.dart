
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/features/home/domain/entities/home_summary_entity.dart';
import 'package:project_pulse/features/projects/presentation/providers/projects_provider.dart';

class HomeNotifier extends AsyncNotifier<HomeSummary> {
  @override
  Future<HomeSummary> build() async {
    // Re-run whenever the projects list changes.
    final projectsState = ref.watch(projectsProvider);

    return projectsState.when(
      loading: () => Future.value(const HomeSummary(
        projectsCount: 0,
        tasksCount: 0,
        completedTasks: 0,
        inProgressTasks: 0,
        pendingTasks: 0,
        recentProjects: [],
      )),
      error: (e, st) => Future.error(e, st),
      data: (projects) {
        // ── Derive counts from real project list ────────────────────────────
        final completed = projects
            .where((p) =>
                p.status.toLowerCase() == 'completed' ||
                p.status.toLowerCase() == 'done')
            .length;

        final inProgress = projects
            .where((p) =>
                p.status.toLowerCase() == 'active' ||
                p.status.toLowerCase() == 'in progress')
            .length;

        final pending = projects
            .where((p) =>
                p.status.toLowerCase() == 'planning' ||
                p.status.toLowerCase() == 'pending')
            .length;

        // tasksCount: sum tasksCount field if your entity has it,
        // otherwise fall back to project count * average tasks.
        // Replace `p.tasksCount` with the real field name when available.
        // final totalTasks = projects.fold<int>(
        //   0,
        //   (sum, p) {
        //     final count = (p as dynamic).tasksCount as int? ?? 0;
        //     return sum + count;
        //   },
        // );

        // Sort by most recent / highest priority and take top 4.
        final recent = [...projects]
          ..sort((a, b) {
            // Prioritise active > planning > completed
            int rank(String s) => switch (s.toLowerCase()) {
                  'active' || 'in progress' => 0,
                  'planning' || 'pending'   => 1,
                  _                         => 2,
                };
            return rank(a.status).compareTo(rank(b.status));
          });

        return Future.value(HomeSummary(
          projectsCount: projects.length,
          tasksCount: projects.length,
          completedTasks: completed,
          inProgressTasks: inProgress,
          pendingTasks: pending,
          recentProjects: recent.take(4).toList(),
        ));
      },
    );
  }

  Future<void> refresh() async {
    // Refreshing projects is enough — build() will react automatically.
    await ref.read(projectsProvider.notifier).refresh();
  }
}