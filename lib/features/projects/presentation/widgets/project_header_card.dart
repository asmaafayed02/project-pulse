import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import '../../domain/entities/project_entity.dart';

class ProjectHeaderCard extends StatelessWidget {
  final ProjectEntity project;
  const ProjectHeaderCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.s20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r20),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Icon + Status row ──────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.s12),
                decoration: BoxDecoration(
                  color: context.colors.onPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
                child: Icon(
                  Icons.folder_rounded,
                  color: context.colors.onPrimary,
                  size: AppSizes.icon24,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.s12,
                  vertical: AppSizes.s8,
                ),
                decoration: BoxDecoration(
                  color: context.colors.onPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                ),
                child: Text(
                  project.status,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.s16),

          // ── Title ─────────────────────────────────
          Text(
            project.title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: context.colors.onPrimary,
              height: 1.2,
            ),
          ),

          SizedBox(height: AppSizes.s8),

          // ── Description ───────────────────────────
          Text(
            project.description,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.onPrimary.withValues(alpha: 0.75),
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: AppSizes.s20),

          // ── Bottom row ────────────────────────────
          Container(
            padding: EdgeInsets.all(AppSizes.s12),
            decoration: BoxDecoration(
              color: context.colors.onPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: AppSizes.icon16,
                  color: context.colors.onPrimary.withValues(alpha: 0.8),
                ),
                SizedBox(width: AppSizes.s8),
                
                Text(
                  'Due ${project.dueDate}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.onPrimary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.bar_chart_rounded,
                  size: AppSizes.icon16,
                  color: context.colors.onPrimary.withValues(alpha: 0.8),
                ),
                SizedBox(width: AppSizes.s8),
                Text(
                  project.priority,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.onPrimary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}