import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/timer/timer_bloc.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/custom_button.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class CreateTimerScreen extends StatefulWidget {
  const CreateTimerScreen({super.key});

  @override
  State<CreateTimerScreen> createState() => _CreateTimerScreenState();
}

class _CreateTimerScreenState extends State<CreateTimerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedProjectId;
  String _deadline = '';
  bool _isFavorite = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Timer',
        showBackButton: true,
        onBackPressed: () => context.go('/'),
      ),
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title Input
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Timer Title',
                            hintText: 'Enter timer title',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Description Input
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter timer description',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Project Selection
                        BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, state) {
                            final projects = context.read<TimerBloc>().projects;
                            return DropdownButtonFormField<String>(
                              value: _selectedProjectId,
                              decoration: const InputDecoration(
                                labelText: 'Project',
                                hintText: 'Select a project',
                              ),
                              items: projects.map((project) {
                                return DropdownMenuItem(
                                  value: project.id,
                                  child: Text('${project.code} - ${project.name}'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedProjectId = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Project is required';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Deadline Input
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Deadline',
                            hintText: 'Select deadline',
                          ),
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().add(const Duration(days: 1)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() {
                                _deadline = date.toIso8601String().split('T')[0];
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Deadline is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Favorite Checkbox
                        CheckboxListTile(
                          title: const Text('Mark as favorite'),
                          value: _isFavorite,
                          onChanged: (value) {
                            setState(() {
                              _isFavorite = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Submit Button
                CustomButton(
                  text: 'Create Timer',
                  icon: Icons.add,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<TimerBloc>().add(
            AddTimer(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              projectId: _selectedProjectId!,
              deadline: _deadline,
              isFavorite: _isFavorite,
            ),
          );
      
      // Navigate back to timer list
      context.go('/');
    }
  }
} 