import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/utils/snackbar_helper.dart';
import 'package:project_pulse/core/utils/validators.dart';
import 'package:project_pulse/core/widgets/buttons/primary_button.dart';
import 'package:project_pulse/core/widgets/inputs/app_text_field.dart';
import '../providers/projects_provider.dart';

class CreateProjectPage extends ConsumerStatefulWidget {
  const CreateProjectPage({super.key});

  @override
  ConsumerState<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends ConsumerState<CreateProjectPage> {
  final _formKey            = GlobalKey<FormState>();
  final _titleController    = TextEditingController();
  final _descController     = TextEditingController();

  String _selectedStatus   = 'active';
  String _selectedPriority = 'medium';
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context:     context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate:   DateTime.now(),
      lastDate:    DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      showErrorSnackBar(context, 'Please select a due date');
      return;
    }

    await ref.read(projectsProvider.notifier).createProject(
          title:       _titleController.text.trim(),
          description: _descController.text.trim(),
          status:      _selectedStatus,
          priority:    _selectedPriority,
          dueDate:     _selectedDate!.toIso8601String(),
        );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(projectsProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Project',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.all(AppSizes.s24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Title ────────────────────────────────
              AppTextField(
                hint:       'Enter project title',
                label:      'Title',
                controller: _titleController,
                prefixIcon: Icon(
                  Icons.folder_outlined,
                  color: context.colors.primary,
                ),
                validator: (v) => Validators.required(v, fieldName: 'Title'),
              ),

              SizedBox(height: AppSizes.s16),

              // ── Description ──────────────────────────
              AppTextField(
                hint:            'Enter project description',
                label:           'Description',
                controller:      _descController,
                maxLines:        4,
                textInputAction: TextInputAction.newline,
                prefixIcon: Icon(
                  Icons.description_outlined,
                  color: context.colors.primary,
                ),
                validator: (v) => Validators.required(v, fieldName: 'Description'),
              ),

              SizedBox(height: AppSizes.s16),

              // ── Status ───────────────────────────────
              Text(
                'Status',
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              _SegmentedRow(
                options:  const ['active', 'completed', 'archived'],
                selected: _selectedStatus,
                onChanged: (v) => setState(() => _selectedStatus = v),
              ),

              SizedBox(height: AppSizes.s16),

              // ── Priority ─────────────────────────────
              Text(
                'Priority',
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              _SegmentedRow(
                options:  const ['low', 'medium', 'high'],
                selected: _selectedPriority,
                onChanged: (v) => setState(() => _selectedPriority = v),
              ),

              SizedBox(height: AppSizes.s16),

              // ── Due Date ─────────────────────────────
              Text(
                'Due Date',
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(AppSizes.r12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.s16),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outlineVariant),
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                    color: context.colors.surface,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: context.colors.primary,
                        size: AppSizes.icon20,
                      ),
                      SizedBox(width: AppSizes.s12),
                      Text(
                        _selectedDate == null
                            ? 'Select due date'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: _selectedDate == null
                              ? context.colors.onSurface.withValues(alpha: 0.4)
                              : context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSizes.s32),

              // ── Submit ───────────────────────────────
              PrimaryButton(
                text:      'Create Project',
                isLoading: isLoading,
                onPressed: _submit,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// ── Segmented Row ────────────────────────────────────
class _SegmentedRow extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  const _SegmentedRow({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final isSelected = option == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                right: option != options.last ? AppSizes.s8 : 0,
              ),
              padding: EdgeInsets.symmetric(vertical: AppSizes.s12),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.surface,
                borderRadius: BorderRadius.circular(AppSizes.r8),
                border: Border.all(
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.outlineVariant,
                ),
              ),
              child: Text(
                option[0].toUpperCase() + option.substring(1),
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? context.colors.onPrimary
                      : context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}