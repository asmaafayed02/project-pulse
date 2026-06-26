import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';

class RecentProjectsSection extends StatelessWidget {
  final List<ProjectEntity> projects;
  final VoidCallback onSeeAll;
  final ValueChanged<ProjectEntity> onProjectTap;

  const RecentProjectsSection({
    super.key,
    required this.projects,
    required this.onSeeAll,
    required this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ──────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Projects',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See all',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.s12),

        // ── Project tiles ───────────────────────
        if (projects.isEmpty)
          _EmptyRecent()
        else
          ...projects.take(4).map(
                (p) => _RecentProjectTile(
                  project: p,
                  onTap: () => onProjectTap(p),
                ),
              ),
      ],
    );
  }
}

// ── Single project tile ───────────────────────────────

class _RecentProjectTile extends StatelessWidget {
  final ProjectEntity project;
  final VoidCallback onTap;

  const _RecentProjectTile({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Derive a progress value from status as a fallback when no real value exists.
    // Replace with project.progress once your entity has it.
    final double progress = switch (project.status.toLowerCase()) {
      'completed' || 'done'  => 1.0,
      'active' || 'in progress' => 0.5,
      'planning'             => 0.1,
      _                     => 0.0,
    };
    final progressPercent = (progress * 100).round();

    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.s10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.r14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.s14,
            vertical: AppSizes.s12,
          ),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r14),
            border: Border.all(
              color: context.colors.outlineVariant,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSizes.r10),
                ),
                child: Icon(
                  Icons.folder_outlined,
                  size: AppSizes.icon16,
                  color: context.colors.primary,
                ),
              ),

              SizedBox(width: AppSizes.s12),

              // Title + progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSizes.s6),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSizes.r4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 5,
                              backgroundColor: context.colors.outlineVariant
                                  .withValues(alpha: 0.6),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _progressColor(project.status),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.s8),
                        Text(
                          '$progressPercent%',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: _progressColor(project.status),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppSizes.s8),

              Icon(
                Icons.chevron_right_rounded,
                size: AppSizes.icon16,
                color: context.colors.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _progressColor(String status) {
    return switch (status.toLowerCase()) {
      'completed' || 'done' => AppColors.success,
      'active' || 'in progress' => AppColors.info,
      _ => AppColors.grey400,
    };
  }
}

// ── Empty recent state ────────────────────────────────

class _EmptyRecent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
      child: Center(
        child: Text(
          'No recent projects',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}