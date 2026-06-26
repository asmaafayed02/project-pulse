import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

// ── Section wrapper ───────────────────────────────────────────────────────────

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSizes.s4, bottom: AppSizes.s8),
          child: Text(
            title.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.onSurface.withValues(alpha: 0.45),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              fontSize: 11,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r16),
            border: Border.all(
              color: context.colors.outlineVariant,
              width: 1.5,
            ),
          ),
          child: Column(
            children: _withDividers(context, children),
          ),
        ),
      ],
    );
  }

  List<Widget> _withDividers(BuildContext context, List<Widget> items) {
    if (items.isEmpty) return [];
    final result = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(Divider(
          height: 1,
          indent: AppSizes.s16,
          endIndent: AppSizes.s16,
          color: context.colors.outlineVariant.withValues(alpha: 0.6),
        ));
      }
    }
    return result;
  }
}

// ── Settings tile ─────────────────────────────────────────────────────────────

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.trailing,
    this.onTap,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? context.colors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r16),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s14,
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.r10),
              ),
              child: Icon(
                icon,
                size: AppSizes.icon18,
                color: effectiveIconColor,
              ),
            ),

            SizedBox(width: AppSizes.s12),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppSizes.s2),
                    Text(
                      subtitle!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurface.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Trailing or chevron
            if (trailing != null)
              trailing!
            else if (showChevron)
              Icon(
                Icons.chevron_right_rounded,
                size: AppSizes.icon18,
                color: context.colors.onSurface.withValues(alpha: 0.3),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Theme selector tile ───────────────────────────────────────────────────────

class ThemePickerTile extends StatelessWidget {
  final String currentLabel;
  final VoidCallback onTap;

  const ThemePickerTile({
    super.key,
    required this.currentLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: Icons.contrast_rounded,
      title: 'Theme',
      trailing: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.s10,
            vertical: AppSizes.s4,
          ),
          decoration: BoxDecoration(
            color: context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentLabel,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: AppSizes.s4),
              Icon(
                Icons.expand_more_rounded,
                size: 14,
                color: context.colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}