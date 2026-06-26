import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/features/tasks/domain/entities/task_entity.dart';
import 'package:project_pulse/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:project_pulse/features/tasks/presentation/wigets/task_card.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final String projectId;
  final WidgetRef ref;

  const TaskItem({super.key, 
    required this.task,
    required this.projectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.s8),
      child: TaskCard(
        task: task,
        onMarkDone: task.isDone
            ? null
            : () => ref
                .read(tasksProvider(projectId).notifier)
                .markAsDone(task),
      ),
    );
  }
}