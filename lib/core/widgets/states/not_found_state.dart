import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class NotFoundState extends StatelessWidget {
  final String path;
  final VoidCallback onGoHome;

  const NotFoundState({
    super.key,
    required this.path,
    required this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.s20),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_off_rounded,
                  size: AppSizes.icon24 * 2,
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: AppSizes.s16),
              Text(
                'Oops! Page not found',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              Text(
                path,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.4),
                ),
              ),
              SizedBox(height: AppSizes.s24),
              FilledButton.icon(
                onPressed: onGoHome,
                icon: const Icon(Icons.home_rounded, size: 18),
                label: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}