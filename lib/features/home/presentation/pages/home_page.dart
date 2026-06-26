import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/errors/error_message_mapper.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/features/auth/presentation/providers/auth_provider.dart';
import 'package:project_pulse/features/home/presentation/widgets/home_skeleton.dart';
import 'package:project_pulse/features/home/presentation/widgets/status_row.dart';
import '../providers/home_provider.dart';
import '../widgets/home_greeting.dart';
import '../widgets/overall_progress_card.dart';
import '../widgets/recent_projects_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    final authValue = ref.watch(authProvider);
    final user = authValue.value; // safe null during loading/error

    final userName = (user != null && user.firstName.trim().isNotEmpty)
        ? '${user.firstName} ${user.lastName}'.trim()
        : 'there';

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: homeState.when(
        loading: () => const HomeSkeleton(),

          error: (error, _)  => Center(
  child: Padding(
    padding: EdgeInsets.all(AppSizes.s24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.colors.errorContainer,
            borderRadius: BorderRadius.circular(AppSizes.r16),
          ),
          child: Icon(
            Icons.error_outline_rounded,
            size: AppSizes.avatar40,
            color: context.colors.error,
          ),
        ),
        SizedBox(height: AppSizes.s16),
        Text(
          'Failed to load dashboard',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSizes.s8),
        Text(
          ErrorMessageMapper.map(error), // ← the friendly, mapped message
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.5),
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppSizes.s20),
        FilledButton.icon(
          onPressed: () => ref.invalidate(homeProvider),
          icon: const Icon(Icons.refresh_rounded, size: 18),
          label: const Text('Retry'),
          style: FilledButton.styleFrom(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
          ),
        ),
      ],
    ),
  ),
),
          data: (summary) => RefreshIndicator(
            color: context.colors.primary,
            strokeWidth: 2.5,
            onRefresh: () => ref.read(homeProvider.notifier).refresh(),
            child: CustomScrollView(
              slivers: [
                // ── Greeting ─────────────────────────
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.s16,
                    AppSizes.s16,
                    AppSizes.s16,
                    AppSizes.s0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: HomeGreeting(
                      userName: userName,
                    ),
                  ),
                ),

                // ── Stats ─────────────────────────────
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.s16,
                    AppSizes.s20,
                    AppSizes.s16,
                    AppSizes.s0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: StatsRow(
                      projectsCount: summary.projectsCount,
                      tasksCount: summary.tasksCount,
                    ),
                  ),
                ),

                // ── Overall progress ──────────────────
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.s16,
                    AppSizes.s12,
                    AppSizes.s16,
                    AppSizes.s0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: OverallProgressCard(
                      completedTasks: summary.completedTasks,
                      inProgressTasks: summary.inProgressTasks,
                      pendingTasks: summary.pendingTasks,
                    ),
                  ),
                ),

                // ── Recent projects ───────────────────
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.s16,
                    AppSizes.s20,
                    AppSizes.s16,
                    AppSizes.s32,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: RecentProjectsSection(
                      projects: summary.recentProjects,
                      onSeeAll: () => context.pushTo(RouteNames.projects),
                      onProjectTap: (project) => context.pushTo(
                        RouteNames.projectDetails,
                        extra: project,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
