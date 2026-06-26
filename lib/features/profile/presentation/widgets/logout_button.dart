import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _confirm(context),
        icon: Icon(
          Icons.logout_rounded,
          size: AppSizes.icon18,
          color: AppColors.error,
        ),
        label: Text(
          'Logout',
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.error,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
          padding: EdgeInsets.symmetric(vertical: AppSizes.s14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r16),
          ),
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) onTap();
  }
}