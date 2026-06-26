import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_pulse/core/network/dio_provider.dart';
import 'package:project_pulse/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:project_pulse/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/update_task_usecase.dart';
import 'task_notifier.dart';

// ── DI ───────────────────────────────────────────────
final tasksRemoteDataSourceProvider = Provider(
  (ref) => TasksRemoteDataSourceImpl(ref.read(apiClientProvider)),
);

final tasksRepositoryProvider = Provider(
  (ref) => TasksRepositoryImpl(ref.read(tasksRemoteDataSourceProvider)),
);

final getAllTasksUseCaseProvider = Provider(        // ← Provider عادي
  (ref) => GetAllTasksUseCase(ref.read(tasksRepositoryProvider)),
);
final getTasksUseCaseProvider = Provider(
  (ref) => GetTasksUseCase(ref.read(tasksRepositoryProvider)),
);

final createTaskUseCaseProvider = Provider(
  (ref) => CreateTaskUseCase(ref.read(tasksRepositoryProvider)),
);

final updateTaskUseCaseProvider = Provider(
  (ref) => UpdateTaskUseCase(ref.read(tasksRepositoryProvider)),
);

// ── Family Provider ───────────────────────────────────
final tasksProvider = StateNotifierProvider.family<  // ← < مش مسافة
    TasksNotifier,
    AsyncValue<List<TaskEntity>>,
    String>(
  (ref, projectId) => TasksNotifier(
    getTasks:   ref.read(getTasksUseCaseProvider),
    createTask: ref.read(createTaskUseCaseProvider),
    updateTask: ref.read(updateTaskUseCaseProvider),
    projectId:  projectId,
  ),
);

// ── All tasks (single request → grouped by projectId) ─
final allTasksProvider = FutureProvider<Map<String, List<TaskEntity>>>(
  (ref) async {
    final usecase = ref.read(getAllTasksUseCaseProvider); 
    final result  = await usecase();
    return result.fold(
      (failure) => throw failure.message,
      (tasks) {
        final Map<String, List<TaskEntity>> grouped = {};
        for (final task in tasks) {
          grouped.putIfAbsent(task.projectId, () => []).add(task);
        }
        return grouped;
      },
    );
  },
);