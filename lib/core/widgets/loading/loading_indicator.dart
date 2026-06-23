import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/extensions/widget_extension.dart';


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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppSizes.avatar56 * 1.6,
            color: AppColors.grey400,
          ),
      
          SizedBox(height: AppSizes.s16),
      
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
      
          SizedBox(height: AppSizes.s8),
      
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      
          if (action != null) ...[
            SizedBox(height: AppSizes.s24),
            action!,
          ],
        ],
      ).withPadding(  
        EdgeInsets.all(AppSizes.s24),
      ),
    );
  }
}