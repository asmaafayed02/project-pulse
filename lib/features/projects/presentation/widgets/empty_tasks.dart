import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class EmptyTasks extends StatelessWidget {
  final VoidCallback onAddTask;
  const EmptyTasks({super.key, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s32),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.s20),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.checklist_rounded,
                size: AppSizes.icon24 * 2,
                color: context.colors.primary.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: AppSizes.s16),
            Text(
              'No tasks yet',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: AppSizes.s4),
            Text(
              'Add your first task to get started',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.35),
              ),
            ),
            SizedBox(height: AppSizes.s20),
            FilledButton.icon(
              onPressed: onAddTask,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Task'),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.s24,
                  vertical: AppSizes.s12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}