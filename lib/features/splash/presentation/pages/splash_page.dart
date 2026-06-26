import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_durations.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/extensions/navigation_extension.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/core/widgets/common/app_logo.dart';
import 'package:project_pulse/features/auth/presentation/providers/auth_provider.dart';
import '../providers/splash_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  ProviderSubscription<AsyncValue<bool>>? _subscription;
  @override
  void initState() {
    super.initState();
    _setupAnimations();

  _navigate();
  }
  Future<void> _navigate() async {
    // Small delay for splash visibility.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
 
    // authProvider starts with getCurrentUser() 
    final user = ref.read(authProvider).value;
    context.go(user != null ? RouteNames.home : RouteNames.login);
  }
 

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.splash,
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _subscription?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
        colors: context.isDark
            ? const [
                AppColors.splashGradientDark1,
                AppColors.splashGradientDark2,
                AppColors.splashGradientDark3,
              ]
            : const [
                AppColors.splashGradientLight1,
                AppColors.splashGradientLight2,
                AppColors.splashGradientLight3,
              ]
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Animated Logo ──────────────────────
                ScaleTransition(
                  scale: _scaleAnimation,
                   child: const AppLogo(),
                ),

                SizedBox(height: AppSizes.s24),

                // ── ProjectPulse wordmark ──────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.colors.onPrimary,
                        letterSpacing: -0.5,
                      ),
                      children:  [
                        TextSpan(text: 'Project'),
                        TextSpan(
                          text: 'Pulse',
                          style: TextStyle(color: context.colors.secondary),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.s8),

                // ── Tagline ────────────────────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Plan smarter. Deliver faster.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onPrimary.withValues(alpha: 0.7),
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}