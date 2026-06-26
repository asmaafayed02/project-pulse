import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';
import 'package:project_pulse/core/utils/validators.dart';
import 'package:project_pulse/core/widgets/buttons/primary_button.dart';
import 'package:project_pulse/core/widgets/inputs/app_text_field.dart';
import '../../domain/usecases/create_task_usecase.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final String projectId;
  final Future<void> Function(CreateTaskParams) onSubmit;

  const AddTaskBottomSheet({
    super.key,
    required this.projectId,
    required this.onSubmit,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey      = GlobalKey<FormState>();
  final _titleCtrl    = TextEditingController();
  final _descCtrl     = TextEditingController();
  final _assigneeCtrl = TextEditingController();

  String    _priority    = 'medium';
  String    _status      = 'pending';
  DateTime? _selectedDate;
  bool      _isLoading   = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _assigneeCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context:     context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate:   DateTime.now(),
      lastDate:    DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) return;

    setState(() => _isLoading = true);

    await widget.onSubmit(
      CreateTaskParams(
        title:       _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        status:      _status,
        priority:    _priority,
        dueDate:     '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
        projectId:   widget.projectId,
        assignee:    _assigneeCtrl.text.trim(),
      ),
    );

    setState(() => _isLoading = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSizes.s24,
        AppSizes.s16,
        AppSizes.s24,
        MediaQuery.of(context).viewInsets.bottom + AppSizes.s24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              // ── Handle ───────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.outlineVariant,
                    borderRadius: BorderRadius.circular(AppSizes.r4),
                  ),
                ),
              ),
          
              SizedBox(height: AppSizes.s16),
          
              Text(
                'Add New Task',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
          
              SizedBox(height: AppSizes.s20),
          
              // ── Title ─────────────────────────────────
              AppTextField(
                hint:       'Task title',
                label:      'Title',
                controller: _titleCtrl,
                prefixIcon: Icon(Icons.title_rounded, color: context.colors.primary),
                validator:  (v) => Validators.required(v, fieldName: 'Title'),
              ),
          
              SizedBox(height: AppSizes.s12),
          
              // ── Description ───────────────────────────
              AppTextField(
                hint:            'Task description (optional)',
                label:           'Description',
                controller:      _descCtrl,
                maxLines:        3,
                textInputAction: TextInputAction.newline,
                prefixIcon: Icon(Icons.notes_rounded, color: context.colors.primary),
              ),
          
              SizedBox(height: AppSizes.s12),
          
              // ── Assignee ──────────────────────────────
              AppTextField(
                hint:       'Assignee name',
                label:      'Assignee',
                controller: _assigneeCtrl,
                prefixIcon: Icon(Icons.person_outline, color: context.colors.primary),
              ),
          
              SizedBox(height: AppSizes.s16),
          
              // ── Priority ──────────────────────────────
              Text('Priority', style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: AppSizes.s8),
              Row(
                children: ['low', 'medium', 'high'].map((p) {
                  final isSelected = _priority == p;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = p),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: p != 'high' ? AppSizes.s8 : 0),
                        padding: EdgeInsets.symmetric(vertical: AppSizes.s10),
                        decoration: BoxDecoration(
                          color: isSelected ? context.colors.primary : context.colors.surface,
                          borderRadius: BorderRadius.circular(AppSizes.r8),
                          border: Border.all(
                            color: isSelected ? context.colors.primary : context.colors.outlineVariant,
                          ),
                        ),
                        child: Text(
                          p[0].toUpperCase() + p.substring(1),
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: isSelected ? context.colors.onPrimary : context.colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
          
              SizedBox(height: AppSizes.s16),
          
              // ── Due Date ──────────────────────────────
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(AppSizes.r12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.s14),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outlineVariant),
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, color: context.colors.primary, size: AppSizes.icon20),
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
          
              SizedBox(height: AppSizes.s24),
          
              // ── Submit ────────────────────────────────
              PrimaryButton(
                text:      'Create Task',
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}