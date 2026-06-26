import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class StatsRow extends StatelessWidget {
  final int projectsCount;
  final int tasksCount;

  const StatsRow({
    super.key,
    required this.projectsCount,
    required this.tasksCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Projects',
            value: projectsCount.toString(),
            icon: Icons.folder_copy_outlined,
          ),
        ),
        SizedBox(width: AppSizes.s12),
        Expanded(
          child: _StatCard(
            label: 'Tasks',
            value: tasksCount.toString(),
            icon: Icons.task_alt_outlined,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s16,
        vertical: AppSizes.s14,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: context.colors.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colors.primaryContainer,
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: Icon(
              icon,
              size: AppSizes.icon18,
              color: context.colors.primary,
            ),
          ),
          SizedBox(width: AppSizes.s12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              SizedBox(height: AppSizes.s4),
              Text(
                label,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}