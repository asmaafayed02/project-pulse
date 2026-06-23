import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/extensions/context_extension.dart';



class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.avatar56 * 1.6,
              color: context.colors.outlineVariant,
            ),

            SizedBox(height: AppSizes.s16),

            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),

            SizedBox(height: AppSizes.s8),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),

            if (action != null) ...[
              SizedBox(height: AppSizes.s24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}