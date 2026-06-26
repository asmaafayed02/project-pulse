import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/core/widgets/states/empty_state.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/presentation/providers/projects_provider.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/project_tasks_preview.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/task_card.dart';



class AllTasksPage extends ConsumerWidget {
  const AllTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsState = ref.watch(projectsProvider);
    final allTasksState = ref.watch(allTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Tasks',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: projectsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text(e.toString())),
        data: (projects) {
          if (projects.isEmpty) {
            return EmptyState(
              icon:     Icons.checklist_rounded,
              title:    'No Tasks Yet',
              subtitle: 'Create a project first\nthen add tasks to it.',
              action: FilledButton.icon(
                onPressed: () => context.pushTo(RouteNames.createProject),
                icon: const Icon(Icons.add),
                label: const Text('New Project'),
              ),
            );
          }

          return allTasksState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:   (e, _) => Center(child: Text(e.toString())),
            data: (groupedTasks) => RefreshIndicator(
              color: context.colors.primary,
              onRefresh: () async {
                ref.invalidate(projectsProvider);
                ref.invalidate(allTasksProvider);
              },
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.s16, AppSizes.s8,
                  AppSizes.s16, AppSizes.s32,
                ),
                itemCount: projects.length,
                itemBuilder: (_, i) {
                  final project = projects[i];
                  return _ProjectTasksSection(
  project: project,
  tasks: groupedTasks[project.id] ?? [],
);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Section ───────────────────────────────────────────
class _ProjectTasksSection extends StatelessWidget {
  final ProjectEntity project;
  final List<TaskEntity> tasks;

  const _ProjectTasksSection({
    required this.project,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ── Project header ──────────────────────────
        InkWell(
          onTap: () => context.pushTo(RouteNames.tasks, extra: project),
          borderRadius: BorderRadius.circular(AppSizes.r12),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.s8),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSizes.s8),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                  ),
                  child: Icon(
                    Icons.folder_rounded,
                    color: context.colors.primary,
                    size: AppSizes.icon16,
                  ),
                ),
                SizedBox(width: AppSizes.s8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${tasks.length} tasks',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: context.colors.onSurface.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),

        // ── Tasks preview ────────────────────────────
       
        ProjectTasksPreview(
          project: project,
          tasks: tasks,
        ),


        SizedBox(height: AppSizes.s8),
        Divider(color: context.colors.outlineVariant),
        SizedBox(height: AppSizes.s8),
      ],
    );
  }
}