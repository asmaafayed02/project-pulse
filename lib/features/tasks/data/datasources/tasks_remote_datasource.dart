import 'package:dio/dio.dart';
import 'package:project_pulse/core/api/endpoints.dart';
import 'package:project_pulse/core/network/api_client.dart';
import '../models/task_model.dart';

abstract interface class TasksRemoteDataSource {
    Future<List<TaskModel>> getAllTasks();        
  Future<List<TaskModel>> getTasks(String projectId);
  Future<TaskModel>       createTask(TaskModel task);
  Future<TaskModel>       updateTask(TaskModel task);
  Future<void>            deleteTask(String id);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final ApiClient _client;
  TasksRemoteDataSourceImpl(this._client);
@override
Future<List<TaskModel>> getAllTasks() async {
  try {
    final response = await _client.get(Endpoints.tasks);
    return (response.data as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) return [];
    rethrow;
  }
}

@override
Future<List<TaskModel>> getTasks(String projectId) async {
  try {
    final response = await _client.get(
      Endpoints.tasks,
    );
    final all = (response.data as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
    return all.where((t) => t.projectId.toString() == projectId.toString()).toList();
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) return [];
    rethrow;
  }
}



  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final response = await _client.post(
      Endpoints.tasks,
      data: task.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await _client.put(
      '${Endpoints.tasks}/${task.id}',
      data: task.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _client.delete('${Endpoints.tasks}/$id');
  }
}