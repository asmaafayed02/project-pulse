import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/core/widgets/states/empty_state.dart';
import '../providers/projects_provider.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsState = ref.watch(projectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projects',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: context.colors.primary),
            onPressed: () => context.pushTo(RouteNames.createProject),
          ),
        ],
      ),

      body: projectsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: AppSizes.icon24 * 3,
                color: context.colors.error,
              ),
              SizedBox(height: AppSizes.s16),
              Text(
                error.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.error,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.s16),
              TextButton.icon(
                onPressed: () => ref.invalidate(projectsProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),

        data: (projects) {
          if (projects.isEmpty) {
            return EmptyState(
              icon: Icons.folder_open_outlined,
              title: 'No Projects Yet',
              subtitle: 'Create your first project\nand start managing tasks.',
              action: FilledButton.icon(
                onPressed: () => context.pushTo(RouteNames.createProject),
                icon: const Icon(Icons.add),
                label: const Text('New Project'),
              ),
            );
          }

          return RefreshIndicator(
            color: context.colors.primary,
            onRefresh: () => ref.read(projectsProvider.notifier).refresh(),
            child: ListView.separated(
              padding: EdgeInsets.all(AppSizes.s16),
              itemCount: projects.length,
              separatorBuilder: (_, _) => SizedBox(height: AppSizes.s12),
              itemBuilder: (_, index) {
                final project = projects[index];
                return ProjectCard(
                  project: project,
                  onTap: () => context.pushTo(
                    RouteNames.projectDetails,
                    extra: project,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}