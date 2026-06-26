import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:project_pulse/features/tasks/domain/usecases/update_task_usecase.dart';

class TasksNotifier extends StateNotifier<AsyncValue<List<TaskEntity>>> {
  final GetTasksUseCase   _getTasks;
  final CreateTaskUseCase _createTask;
  final UpdateTaskUseCase _updateTask;
  final String            projectId;

  TasksNotifier({
    required this._getTasks,
    required this._createTask,
    required this._updateTask,
    required this.projectId,
  })  : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    final result = await _getTasks(projectId);
    result.fold(
      (f)     => state = AsyncValue.error(f.message, StackTrace.current),
      (tasks) => state = AsyncValue.data(tasks),
    );
  }

  Future<void> createTask(CreateTaskParams params) async {
    final result = await _createTask(params);
    result.fold(
      (f)       => state = AsyncValue.error(f.message, StackTrace.current),
      (newTask) {
        final current = state.value ?? [];
        state = AsyncValue.data([...current, newTask]);
      },
    );
  }

  Future<void> markAsDone(TaskEntity task) async {
    final updated = task.copyWith(status: 'Done');
    final result  = await _updateTask(updated);
    result.fold(
      (f)           => state = AsyncValue.error(f.message, StackTrace.current),
      (updatedTask) {
        final current = state.value ?? [];
        state = AsyncValue.data(
          current.map((t) => t.id == updatedTask.id ? updatedTask : t).toList(),
        );
      },
    );
  }


  Future<void> refresh() => loadTasks();
}