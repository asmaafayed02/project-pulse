import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/widgets/states/empty_state.dart';
import 'package:project_pulse/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/add_task_bottom_sheet.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/task_item.dart';

class TasksPage extends ConsumerWidget {
  final String projectId;
  final String projectTitle;

  const TasksPage({
    super.key,
    required this.projectId,
    required this.projectTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              projectTitle,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppSizes.s12),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () => _showAddTask(context, ref),
            ),
          ),
        ],
      ),

      body: tasksState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded,
                  size: AppSizes.icon24 * 2, color: context.colors.error),
              SizedBox(height: AppSizes.s12),
              Text(e.toString(), textAlign: TextAlign.center),
              SizedBox(height: AppSizes.s12),
              FilledButton.icon(
                onPressed: () =>
                    ref.read(tasksProvider(projectId).notifier).refresh(),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),

        data: (tasks) {
          if (tasks.isEmpty) {
            return EmptyState(
              icon: Icons.checklist_rounded,
              title: 'No Tasks Yet',
              subtitle: 'Add your first task\nto get started.',
              action: FilledButton.icon(
                onPressed: () => _showAddTask(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
              ),
            );
          }

          // ── Group by canonical status ───────────────────────────────────────
          final pending    = tasks.where((t) => t.isPending).toList();
          final inProgress = tasks.where((t) => t.isInProgress).toList();
          final done       = tasks.where((t) => t.isDone).toList();

          return RefreshIndicator(
            color: context.colors.primary,
            onRefresh: () =>
                ref.read(tasksProvider(projectId).notifier).refresh(),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                AppSizes.s16, AppSizes.s8, AppSizes.s16, AppSizes.s32,
              ),
              children: [
                if (pending.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Pending',
                    count: pending.length,
                    color: AppColors.info,
                  ),
                  SizedBox(height: AppSizes.s8),
                  ...pending.map(
                    (t) => TaskItem(task: t, projectId: projectId, ref: ref),
                  ),
                  SizedBox(height: AppSizes.s16),
                ],
                if (inProgress.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'In Progress',
                    count: inProgress.length,
                    color: AppColors.warning,
                  ),
                  SizedBox(height: AppSizes.s8),
                  ...inProgress.map(
                    (t) => TaskItem(task: t, projectId: projectId, ref: ref),
                  ),
                  SizedBox(height: AppSizes.s16),
                ],
                if (done.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Done',
                    count: done.length,
                    color: AppColors.success,
                  ),
                  SizedBox(height: AppSizes.s8),
                  ...done.map(
                    (t) => TaskItem(task: t, projectId: projectId, ref: ref),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddTask(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTaskBottomSheet(
        projectId: projectId,
        onSubmit: (params) =>
            ref.read(tasksProvider(projectId).notifier).createTask(params),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSizes.r4),
          ),
        ),
        SizedBox(width: AppSizes.s8),
        Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: AppSizes.s8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.s8,
            vertical: AppSizes.s2,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
          child: Text(
            '$count',
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}