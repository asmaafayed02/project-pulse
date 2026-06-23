import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_pulse/features/splash/presentation/pages/splash_page.dart';

import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,

    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const _PlaceholderPage('Login'),
      ),

      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const _PlaceholderPage('Register'),
      ),

      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const _PlaceholderPage('Home'),
      ),

      GoRoute(
        path: RouteNames.projectDetails,
        builder: (context, state) => const _PlaceholderPage('Project Details'),
      ),

      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const _PlaceholderPage('Profile'),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found\n${state.uri}'),
      ),
    ),
  );
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title),
      ),
    );
  }
}