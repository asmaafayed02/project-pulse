import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/features/home/domain/entities/nav_item_entity.dart';
import 'package:project_pulse/features/home/presentation/pages/home_page.dart';
import 'package:project_pulse/features/home/presentation/providers/home_provider.dart';
import 'package:project_pulse/features/projects/presentation/pages/projects_page.dart';

const _navItems = [
  NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  NavItem(
    icon: Icons.folder_outlined,
    activeIcon: Icons.folder_rounded,
    label: 'Projects',
  ),
  NavItem(
    icon: Icons.task_alt_outlined,
    activeIcon: Icons.task_alt_rounded,
    label: 'Tasks',
  ),
  NavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

// ── Pages — kept alive via IndexedStack ───────────────────────────────────────

const _pages = [
  HomePage(),
  ProjectsPage(),
  Scaffold(body: Center(child: Text('Tasks'))),
  Scaffold(body: Center(child: Text('Profile'))),
];

// ── Main Shell ────────────────────────────────────────────────────────────────

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(shellIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: currentIndex,
        onTap: (i) => ref.read(shellIndexProvider.notifier).state = i,
      ),
    );
  }
}

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(color: context.colors.outlineVariant, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(
              _navItems.length,
              (i) => Expanded(
                child: _NavTile(
                  item: _navItems[i],
                  index: i,
                  isActive: currentIndex == i,
                  onTap: () => onTap(i),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Single nav tile ───────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  final NavItem item;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  // Stable hero tag per tab — must match any Hero tag used on destination pages.
  String get _heroTag => 'nav-icon-$index';

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.colors.primary
        : context.colors.onSurface.withValues(alpha: 0.4);

    return InkWell(
      onTap: onTap,
      splashColor: context.colors.primary.withValues(alpha: 0.08),
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Active indicator pill
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            width: isActive ? 32 : 0,
            height: 3,
            margin: EdgeInsets.only(bottom: AppSizes.s4),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Hero wraps the icon so it can morph into a larger icon
          // on any destination page that uses the same heroTag.
          Hero(
            tag: _heroTag,
            // flightShuttleBuilder keeps the icon visible during flight.
            flightShuttleBuilder: (_, animation, _, fromCtx, toCtx) {
              return AnimatedBuilder(
                animation: animation,
                builder: (_, _) => Icon(
                  isActive ? item.activeIcon : item.icon,
                  color: Color.lerp(
                    context.colors.onSurface.withValues(alpha: 0.4),
                    context.colors.primary,
                    animation.value,
                  ),
                  size: lerpDouble(AppSizes.icon24, 28, animation.value),
                ),
              );
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Icon(
                isActive ? item.activeIcon : item.icon,
                key: ValueKey(isActive),
                color: color,
                size: isActive ? 26 : AppSizes.icon24,
              ),
            ),
          ),

          SizedBox(height: AppSizes.s4),

          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: context.textTheme.labelSmall!.copyWith(
              color: color,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              fontSize: 10,
            ),
            child: Text(item.label),
          ),
        ],
      ),
    );
  }
}

// Helper — avoids importing dart:ui directly.
double lerpDouble(double a, double b, double t) => a + (b - a) * t;