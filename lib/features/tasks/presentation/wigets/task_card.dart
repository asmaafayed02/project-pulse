import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import '../../domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity    task;
  final VoidCallback? onMarkDone;

  const TaskCard({
    super.key,
    required this.task,
    this.onMarkDone,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColor = _priorityColor(task.priority);
    final isDone        = task.isDone;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(
          color: isDone
              ? AppColors.success.withValues(alpha: 0.3)
              : context.colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.s12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Checkbox ──────────────────────────────
            GestureDetector(
              onTap: onMarkDone,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: AppSizes.s24,
                height: AppSizes.s24,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.success : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone ? AppColors.success : context.colors.outline,
                    width: 2,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ),

            SizedBox(width: AppSizes.s12),

            // ── Content ───────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    task.title,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      color: isDone
                          ? context.colors.onSurface.withValues(alpha: 0.4)
                          : context.colors.onSurface,
                    ),
                  ),

                  if (task.description.isNotEmpty) ...[
                    SizedBox(height: AppSizes.s4),
                    Text(
                      task.description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurface.withValues(alpha: 0.5),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  SizedBox(height: AppSizes.s8),

                  // Footer
                  Row(
                    children: [
                      // Priority
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.s6,
                          vertical: AppSizes.s2,
                        ),
                        decoration: BoxDecoration(
                          color: priorityColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSizes.r4),
                        ),
                        child: Text(
                          task.priority,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: priorityColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),

                      SizedBox(width: AppSizes.s8),

                      // Due date
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 11,
                        color: context.colors.onSurface.withValues(alpha: 0.4),
                      ),
                      SizedBox(width: AppSizes.s4),
                      Flexible(
                        child: Text(
                          task.dueDate,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colors.onSurface.withValues(alpha: 0.4),
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const Spacer(),

                      // Assignee
                      if (task.assignee.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.s6,
                            vertical: AppSizes.s2,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppSizes.r4),
                          ),
                          child: Text(
                            task.assignee,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _priorityColor(String priority) => switch (priority.toLowerCase()) {
        'high'   => AppColors.highPriority,
        'medium' => AppColors.mediumPriority,
        'low'    => AppColors.lowPriority,
        _        => AppColors.grey400,
      };
}