import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/network/dio_provider.dart';
import 'package:project_pulse/features/projects/data/datasources/projects_remote_datasource.dart';
import 'package:project_pulse/features/projects/data/repositories/projects_repository_impl.dart';
import 'package:project_pulse/features/projects/domain/repositories/projects_repository.dart';
import 'package:project_pulse/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:project_pulse/features/projects/domain/usecases/get_projects_usecase.dart';

final projectsRemoteDataSourceProvider =
    Provider<ProjectsRemoteDataSource>(
  (ref) => ProjectsRemoteDataSourceImpl(
    ref.read(apiClientProvider),
  ),
);

final projectsRepositoryProvider =
    Provider<ProjectsRepository>(
  (ref) => ProjectsRepositoryImpl(
    ref.read(
      projectsRemoteDataSourceProvider,
    ),
  ),
);

final getProjectsUseCaseProvider =
    Provider<GetProjectsUseCase>(
  (ref) => GetProjectsUseCase(
    ref.read(
            projectsRepositoryProvider,
    ),
  ),
);

final createProjectUseCaseProvider = Provider<CreateProjectUseCase>(
  (ref) => CreateProjectUseCase(
    ref.read(projectsRepositoryProvider),
  ),
);