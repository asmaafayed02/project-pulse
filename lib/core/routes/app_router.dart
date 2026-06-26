import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_pulse/features/auth/presentation/pages/login_page.dart';
import 'package:project_pulse/features/auth/presentation/pages/register_page.dart';
import 'package:project_pulse/features/home/presentation/pages/home_page.dart';
import 'package:project_pulse/features/home/presentation/pages/main_shell.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/presentation/pages/create_project_page.dart';
import 'package:project_pulse/features/projects/presentation/pages/project_details_page.dart';
import 'package:project_pulse/features/projects/presentation/pages/projects_page.dart';
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
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),

      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const MainShell(),
      ),

      GoRoute(
        path: RouteNames.projects,
        builder: (context, state) => const ProjectsPage(),
      ),
      GoRoute(
        path: RouteNames.projectDetails,
        
        builder: (context, state){
           final project = state.extra as ProjectEntity;
           return ProjectDetailsPage(project: project);
        },
      ),

      GoRoute(
        path: RouteNames.createProject,
        builder: (context, state) => const CreateProjectPage(),
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