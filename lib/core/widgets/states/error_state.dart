import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final String buttonLabel;
  final VoidCallback onAction;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    required this.onAction,
    this.buttonLabel = 'Go Back',
    this.icon = Icons.warning_amber_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.s20),
                decoration: BoxDecoration(
                  color: context.colors.error.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: AppSizes.icon24 * 2,
                  color: context.colors.error,
                ),
              ),
              SizedBox(height: AppSizes.s16),
              Text(
                'Something went wrong',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.5),
                ),
              ),
              SizedBox(height: AppSizes.s24),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: Text(buttonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}