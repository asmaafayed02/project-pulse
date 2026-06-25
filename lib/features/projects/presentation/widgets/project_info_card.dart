import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import '../../domain/entities/project_entity.dart';
import 'project_info_row.dart';

class ProjectInfoCard extends StatelessWidget {
  final ProjectEntity project;
  const ProjectInfoCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outlineVariant),
        borderRadius: BorderRadius.circular(AppSizes.r16),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProjectInfoRow(
            icon:        Icons.person_outline_rounded,
            label:       'Owner',
            value:       project.owner,
            showDivider: true,
          ),
          ProjectInfoRow(
            icon:        Icons.flag_outlined,
            label:       'Status',
            value:       project.status,
            valueColor:  _statusColor(project.status),
            showDivider: true,
          ),
          ProjectInfoRow(
            icon:        Icons.bar_chart_rounded,
            label:       'Priority',
            value:       project.priority,
            valueColor:  _priorityColor(project.priority),
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) => switch (status.toLowerCase()) {
        'active'      => AppColors.info,
        'in progress' => AppColors.warning,
        'completed'   => AppColors.success,
        'archived'    => AppColors.grey400,
        _             => AppColors.grey400,
      };

  Color _priorityColor(String priority) => switch (priority.toLowerCase()) {
        'high'   => AppColors.highPriority,
        'medium' => AppColors.mediumPriority,
        'low'    => AppColors.lowPriority,
        _        => AppColors.grey400,
      };
}