import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import '../../domain/entities/project_entity.dart';

class ProjectCard extends StatelessWidget {
  final ProjectEntity project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        side: BorderSide(color: context.colors.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Header Row ──────────────────────────
              Row(
                children: [
                  // Icon
                  Container(
                    width: AppSizes.avatar40,
                    height: AppSizes.avatar40,
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    child: Icon(
                      Icons.folder_outlined,
                      color: context.colors.primary,
                      size: AppSizes.icon20,
                    ),
                  ),

                  SizedBox(width: AppSizes.s12),

                  // Title + date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppSizes.s4),
                        Text(
                          'Due ${project.dueDate}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status badge
                  _StatusBadge(status: project.status),
                ],
              ),

              SizedBox(height: AppSizes.s12),

              // ── Description ─────────────────────────
              Text(
                project.description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: AppSizes.s12),

              // ── Footer Row ──────────────────────────
              Row(
                children: [
                  Icon(
                    Icons.task_alt_outlined,
                    size: AppSizes.icon16,
                    color: context.colors.onSurface.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: AppSizes.s4),
                  // Text(
                  //   '${project.tasksCount} Tasks',
                  //   style: context.textTheme.bodySmall?.copyWith(
                  //     color: context.colors.onSurface.withValues(alpha: 0.5),
                  //   ),
                  // ),

                  const Spacer(),

                  // Priority badge
                  _PriorityBadge(priority: project.priority),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Status Badge ─────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status.toLowerCase()) {
      'active'    => (AppColors.info,       'Active'),
      'completed' => (AppColors.success,    'Done'),
      'archived'  => (AppColors.grey400,    'Archived'),
      _           => (AppColors.grey400,    status),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s8,
        vertical: AppSizes.s4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Priority Badge ───────────────────────────────────
class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (priority.toLowerCase()) {
      'high'   => (AppColors.highPriority,   Icons.arrow_upward_rounded),
      'medium' => (AppColors.mediumPriority, Icons.remove_rounded),
      'low'    => (AppColors.lowPriority,    Icons.arrow_downward_rounded),
      _        => (AppColors.grey400,        Icons.remove_rounded),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSizes.icon16, color: color),
        SizedBox(width: AppSizes.s4),
        Text(
          priority,
          style: context.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}