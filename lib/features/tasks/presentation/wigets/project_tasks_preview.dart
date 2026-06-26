import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/presentation/widgets/empty_tasks.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/task_card.dart';

class ProjectTasksPreview extends ConsumerWidget {
  final ProjectEntity project;

  final List<TaskEntity>? tasks;

  final int maxItems;
  final bool showSeeAll;

  const ProjectTasksPreview({
    super.key,
    required this.project,
    this.tasks,
    this.maxItems = 3,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks != null) {
      return _buildContent(
        context,
        ref,
        tasks!,
      );
    }

    final tasksState = ref.watch(tasksProvider(project.id));

    return tasksState.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(e.toString()),
      ),
      data: (tasks) => _buildContent(
        context,
        ref,
        tasks,
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<TaskEntity> tasks,
  ) {
    if (tasks.isEmpty) {
      return EmptyTasks(
        onAddTask: () {
          context.pushTo(
            RouteNames.tasks,
            extra: project,
          );
        },
      );
    }

    final preview = tasks.take(maxItems).toList();

    return Column(
      children: [
        ...preview.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TaskCard(
              task: task,
              onMarkDone: task.isDone
                  ? null
                  : () => ref
                      .read(tasksProvider(project.id).notifier)
                      .markAsDone(task),
            ),
          ),
        ),

        if (showSeeAll && tasks.length > maxItems)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.pushTo(
                  RouteNames.tasks,
                  extra: project,
                );
              },
              child: Text(
                'See all ${tasks.length} tasks →',
              ),
            ),
          ),
      ],
    );
  }
}