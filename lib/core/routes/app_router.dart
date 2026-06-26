import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_pulse/core/routes/route_names.dart';
import 'package:project_pulse/core/widgets/states/error_state.dart';
import 'package:project_pulse/core/widgets/states/not_found_state.dart';
import 'package:project_pulse/features/auth/presentation/pages/login_page.dart';
import 'package:project_pulse/features/auth/presentation/pages/register_page.dart';
import 'package:project_pulse/features/home/presentation/pages/main_shell.dart';
import 'package:project_pulse/features/profile/presentation/pages/profile_page.dart';
import 'package:project_pulse/features/projects/domain/entities/project_entity.dart';
import 'package:project_pulse/features/projects/presentation/pages/create_project_page.dart';
import 'package:project_pulse/features/projects/presentation/pages/project_details_page.dart';
import 'package:project_pulse/features/projects/presentation/pages/projects_page.dart';
import 'package:project_pulse/features/splash/presentation/pages/splash_page.dart';
import 'package:project_pulse/features/tasks/presentation/pages/project_tasks_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,


    errorBuilder: (context, state) => NotFoundState(
      path:     state.uri.toString(),
      onGoHome: () => context.go(RouteNames.home),
    ),

    routes: [
      GoRoute(
        path:    RouteNames.splash,
        builder: (_, _) => const SplashPage(),
      ),
      GoRoute(
        path:    RouteNames.login,
        builder: (_, _) => const LoginPage(),
      ),
      GoRoute(
        path:    RouteNames.register,
        builder: (_, _) => const RegisterPage(),
      ),
      GoRoute(
        path:    RouteNames.home,
        builder: (_, _) => const MainShell(),
      ),
      GoRoute(
        path:    RouteNames.projects,
        builder: (_, _) => const ProjectsPage(),
      ),
      GoRoute(
        path:    RouteNames.createProject,
        builder: (_, _) => const CreateProjectPage(),
      ),
      GoRoute(
        path: RouteNames.projectDetails,
        builder: (context, state) {
          final project = state.extra;
          if (project is! ProjectEntity) {
            return ErrorState(
              message:  'Project data is missing.',
              onAction: () => context.go(RouteNames.home),
            );
          }
          return ProjectDetailsPage(project: project);
        },
      ),
      GoRoute(
        path: RouteNames.tasks,
        builder: (context, state) {
          final project = state.extra;
          if (project is! ProjectEntity) {
            return ErrorState(
              message:  'Project data is missing.',
              onAction: () => context.go(RouteNames.home),
            );
          }
          return TasksPage(
            projectId:    project.id,
            projectTitle: project.title,
          );
        },
      ),
    
    ],
  );
}