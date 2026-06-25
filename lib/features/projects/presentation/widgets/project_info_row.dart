import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class ProjectInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool showDivider;

  const ProjectInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.s16,
            vertical: AppSizes.s14,
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: AppSizes.s32,
                height: AppSizes.s32,
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Icon(
                  icon,
                  size: AppSizes.icon16,
                  color: context.colors.primary,
                ),
              ),

              SizedBox(width: AppSizes.s12),

              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.55),
                ),
              ),

              const Spacer(),

              // Value with badge if has color
              valueColor != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.s10,
                        vertical: AppSizes.s4,
                      ),
                      decoration: BoxDecoration(
                        color: valueColor!.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSizes.r20),
                      ),
                      child: Text(
                        value,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: valueColor,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
                      ),
                    ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: AppSizes.s16,
            endIndent: AppSizes.s16,
            color: context.colors.outlineVariant,
          ),
      ],
    );
  }
}