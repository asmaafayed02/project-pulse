import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/features/auth/presentation/providers/auth_provider.dart';
import 'package:project_pulse/features/home/presentation/providers/home_provider.dart';
import 'package:project_pulse/features/profile/domain/entities/theme_mode_entity.dart';
import 'package:project_pulse/features/profile/presentation/providers/theme_provider.dart';
import 'package:project_pulse/features/profile/presentation/widgets/logout_button.dart';
import 'package:project_pulse/features/profile/presentation/widgets/profile_header.dart';
import 'package:project_pulse/features/profile/presentation/widgets/settings_section.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ── Auth state ────────────────────────────────────────────────────────────
    final user      = ref.watch(authProvider).value;
    final firstName = user?.firstName ?? '';
    final lastName  = user?.lastName  ?? '';
    final email     = user?.email     ?? '';

    // ── Theme state ───────────────────────────────────────────────────────────
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: context.colors.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: context.colors.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Profile',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppSizes.s16, AppSizes.s8, AppSizes.s16, AppSizes.s40,
        ),
        children: [

          // ── Profile header ────────────────────────────────────────────────
          ProfileHeader(
            firstName: firstName,
            lastName:  lastName,
            email:     email,
          ),

          SizedBox(height: AppSizes.s24),

          // ── Account section ───────────────────────────────────────────────
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon:     Icons.person_outline_rounded,
                title:    'Account Information',
                subtitle: email.isNotEmpty ? email : null,
                onTap:    () {}, // → navigate to edit profile when ready
              ),
              SettingsTile(
                icon:  Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              SettingsTile(
                icon:  Icons.lock_outline_rounded,
                title: 'Privacy & Security',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: AppSizes.s16),

          // ── Appearance section ────────────────────────────────────────────
          SettingsSection(
            title: 'Appearance',
            children: [
              ThemePickerTile(
                currentLabel: _themeLabel(themeMode),
                onTap: () => _showThemePicker(context, ref, themeMode),
              ),
            ],
          ),

          SizedBox(height: AppSizes.s16),

          // ── App section ───────────────────────────────────────────────────
          SettingsSection(
            title: 'App',
            children: [
              SettingsTile(
                icon:     Icons.info_outline_rounded,
                title:    'Version',
                subtitle: '1.0.0',
                showChevron: false,
              ),
              SettingsTile(
                icon:  Icons.star_outline_rounded,
                title: 'Rate App',
                onTap: () {},
              ),
              SettingsTile(
                icon:  Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: AppSizes.s24),

          // ── Logout ────────────────────────────────────────────────────────
          LogoutButton(
            onTap: () => _logout(context, ref),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _themeLabel(AppThemeMode mode) => switch (mode) {
        AppThemeMode.light  => 'Light',
        AppThemeMode.dark   => 'Dark',
        AppThemeMode.system => 'System',
      };

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode current,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ThemePickerSheet(current: current, ref: ref),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
 
  await ref.read(authProvider.notifier).logout();

// Reset shell tab to Home before navigating away.
  ref.read(shellIndexProvider.notifier).state = 0;
  
    // Navigate to login and remove all routes from stack.
      if (context.mounted) {
    context.go(RouteNames.login);
  }

  }
}

// ── Theme picker bottom sheet ─────────────────────────────────────────────────

class _ThemePickerSheet extends ConsumerWidget {
  final AppThemeMode current;
  final WidgetRef ref;

  const _ThemePickerSheet({required this.current, required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef innerRef) {
    final options = [
      (AppThemeMode.light,  Icons.light_mode_rounded,      'Light'),
      (AppThemeMode.dark,   Icons.dark_mode_rounded,       'Dark'),
      (AppThemeMode.system, Icons.brightness_auto_rounded, 'System'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.r24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSizes.s24, AppSizes.s12, AppSizes.s24, AppSizes.s32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(height: AppSizes.s20),

          Text(
            'Choose Theme',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: AppSizes.s16),

          ...options.map((opt) {
            final (mode, icon, label) = opt;
            final isSelected = current == mode;

            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.s8),
              child: InkWell(
                onTap: () {
                  innerRef.read(themeProvider.notifier).setTheme(mode);
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(AppSizes.r14),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s16,
                    vertical: AppSizes.s14,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.primaryContainer
                        : context.colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppSizes.r14),
                    border: Border.all(
                      color: isSelected
                          ? context.colors.primary.withValues(alpha: 0.4)
                          : context.colors.outlineVariant,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: AppSizes.icon20,
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.onSurface.withValues(alpha: 0.6),
                      ),
                      SizedBox(width: AppSizes.s12),
                      Expanded(
                        child: Text(
                          label,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? context.colors.primary
                                : context.colors.onSurface,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          size: AppSizes.icon20,
                          color: context.colors.primary,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}