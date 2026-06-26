import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class HomeGreeting extends StatelessWidget {
  final String userName;
  final String? avatarUrl;

  const HomeGreeting({
    super.key,
    required this.userName,
    this.avatarUrl,
  });

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get _emoji {
    final hour = DateTime.now().hour;
    if (hour < 12) return '☀️';
    if (hour < 17) return '👋';
    return '🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_greeting $_emoji',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.55),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSizes.s2),
              Text(
                userName,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        SizedBox(width: AppSizes.s12),

        // No Hero here — IndexedStack keeps all tabs mounted simultaneously
        // so duplicate Hero tags crash. Hero only works across route pushes,
        // not IndexedStack tab switches.
        _Avatar(url: avatarUrl, name: userName),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  final String name;

  const _Avatar({this.url, required this.name});

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colors.outlineVariant,
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: url != null
            ? Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _InitialsFallback(initials: _initials),
              )
            : _InitialsFallback(initials: _initials),
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  final String initials;
  const _InitialsFallback({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.primaryContainer,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
        ),
      ),
    );
  }
}