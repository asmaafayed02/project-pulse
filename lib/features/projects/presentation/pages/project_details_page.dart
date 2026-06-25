import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/features/projects/presentation/widgets/empty_tasks.dart';
import '../../domain/entities/project_entity.dart';
import '../widgets/project_header_card.dart';
import '../widgets/project_info_card.dart';
import '../widgets/section_title.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ProjectEntity project;
  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProjectHeaderCard(project: project),

            SizedBox(height: AppSizes.s16),

           

            ProjectInfoCard(project: project),

            SizedBox(height: AppSizes.s24),

            SectionTitle(
              title: 'Tasks',
              action: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Task'),
              ),
            ),

            SizedBox(height: AppSizes.s8),

            EmptyTasks(onAddTask: () {}),

          ],
        ),
      ),
    );
  }
}