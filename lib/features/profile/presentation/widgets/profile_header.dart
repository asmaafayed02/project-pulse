import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class ProfileHeader extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatarUrl,
  });

  String get _initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty  ? lastName[0]  : '';
    return '$f$l'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar — no Hero, both HomePage and ProfilePage live in IndexedStack
        // simultaneously so identical Hero tags cause a crash.
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.primaryContainer,
            border: Border.all(
              color: context.colors.primary.withValues(alpha: 0.25),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: avatarUrl != null
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        _Initials(initials: _initials),
                  )
                : _Initials(initials: _initials),
          ),
        ),

        SizedBox(height: AppSizes.s12),

        Text(
          '$firstName $lastName'.trim(),
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),

        SizedBox(height: AppSizes.s4),

        Text(
          email,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _Initials extends StatelessWidget {
  final String initials;
  const _Initials({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.primaryContainer,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
        ),
      ),
    );
  }
}