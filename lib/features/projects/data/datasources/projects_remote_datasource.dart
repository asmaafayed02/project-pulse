import 'package:project_pulse/core/api/endpoints.dart';
import 'package:project_pulse/core/network/api_client.dart';
import 'package:project_pulse/features/projects/data/models/project_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> createProject({  
    required String title,
    required String description,
    required String status,
    required String priority,
    required String dueDate,
  });
}
class ProjectsRemoteDataSourceImpl
    implements ProjectsRemoteDataSource {
  final ApiClient apiClient;
  ProjectsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final response = await apiClient.get(
      Endpoints.projects,
    );

    return (response.data as List)
        .map(
          (e) => ProjectModel.fromJson(e),
        )
        .toList();
  }

  @override
  Future<ProjectModel> createProject({
    required String title,
    required String description,
    required String status,
    required String priority,
    required String dueDate,
  }) async {
    final response = await apiClient.post(
      Endpoints.projects,
      data: {
        'title':       title,
        'description': description,
        'status':      status,
        'priority':    priority,
        'dueDate':     dueDate,
        'tasksCount':  0,
        'createdAt':   DateTime.now().toIso8601String(),
      },
    );
  return ProjectModel.fromJson(response.data);
  }
}