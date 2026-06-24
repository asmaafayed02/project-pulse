import 'package:flutter/material.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

import '../../../../../core/constants/app_sizes.dart';

/// White elevated card that wraps auth form fields.
class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.s24),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(
          AppSizes.r24,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: AppSizes.r20,
            offset: const Offset(0, 8),
            color: context.theme.shadowColor
                .withValues(alpha: .1),
          ),
        ],
      ),
      child: child,
    );
  }
}