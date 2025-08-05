import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/timer/timer_bloc.dart';
import '../widgets/common/custom_app_bar.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class TimerListScreen extends StatelessWidget {
  const TimerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Timesheets',
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sort functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/create');
            },
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                ),
              );
            }

            if (state is TimerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Error: ${state.message}',
                      style: AppTypography.body1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state is TimerLoaded) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You have ${state.timers.length} Timers',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Expanded(
                      child: state.timers.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 64,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(height: AppSpacing.lg),
                                  Text(
                                    'No timers yet',
                                    style: AppTypography.heading2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Create your first timer to get started',
                                    style: AppTypography.body2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.timers.length,
                              itemBuilder: (context, index) {
                                final timer = state.timers[index];
                                return TimerCard(timer: timer);
                              },
                            ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text(
                'Welcome to Timer App',
                style: AppTypography.heading1,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  final dynamic timer; // Using dynamic for now, will be properly typed later

  const TimerCard({
    super.key,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        title: Text(
          timer.title ?? 'Timer',
          style: AppTypography.body1,
        ),
        subtitle: Text(
          'Project: ${timer.project?.name ?? 'Unknown'}',
          style: AppTypography.body2,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '00:00',
              style: AppTypography.body2,
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: Icon(
                timer.isRunning == true ? Icons.pause : Icons.play_arrow,
                color: AppColors.textPrimary,
              ),
              onPressed: () {
                // TODO: Implement play/pause functionality
              },
            ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to task details
        },
      ),
    );
  }
} 