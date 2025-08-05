import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';
import '../models/timer.dart' as timer_model;
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/custom_button.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../utils/helpers.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String timerId;

  const TaskDetailsScreen({
    super.key,
    required this.timerId,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Task Details',
        showBackButton: true,
        onBackPressed: () => context.go('/'),
      ),
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: Column(
          children: [
            // Tab Bar
            Container(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Details'),
                  Tab(text: 'Timesheets'),
                ],
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.textPrimary,
              ),
            ),
            
            // Tab Content
            Expanded(
              child: BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  if (state is TimerLoaded) {
                    final timer = state.timers.firstWhere(
                      (t) => t.id == widget.timerId,
                      orElse: () => throw Exception('Timer not found'),
                    ) as timer_model.Timer;

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDetailsTab(timer),
                        _buildTimesheetsTab(timer),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab(timer_model.Timer timer) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timer.title ?? 'Timer',
                    style: AppTypography.heading2,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Project Info
                  _buildInfoRow(
                    Icons.work,
                    'Project',
                    '${timer.project?.code ?? 'N/A'} - ${timer.project?.name ?? 'Unknown'}',
                  ),
                  
                  // Deadline Info
                  _buildInfoRow(
                    Icons.schedule,
                    'Deadline',
                    timer.deadline ?? 'Not set',
                  ),
                  
                  // Assigned To (static data)
                  _buildInfoRow(
                    Icons.person,
                    'Assigned to',
                    'John Doe',
                  ),
                  
                  // Status
                  _buildInfoRow(
                    Icons.info,
                    'Status',
                    timer.status?.toString().split('.').last ?? 'Unknown',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Description
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppTypography.heading2,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    timer.description ?? 'No description provided',
                    style: AppTypography.body1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimesheetsTab(timer_model.Timer timer) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Timer Display
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    TimeHelpers.formatTime(timer.elapsedTime ?? 0),
                    style: AppTypography.heading1.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Elapsed Time',
                    style: AppTypography.body2,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Timer Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                                             CustomButton(
                         text: timer.isRunning ? 'Pause' : 'Play',
                         icon: timer.isRunning ? Icons.pause : Icons.play_arrow,
                         onPressed: () => _handlePlayPause(timer),
                       ),
                                             CustomButton(
                         text: 'Stop',
                         icon: Icons.stop,
                         backgroundColor: Colors.red.withOpacity(0.2),
                         onPressed: () => _handleStop(timer),
                       ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Timer Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Timer Information',
                    style: AppTypography.heading2,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  
                  _buildSimpleInfoRow('Status', timer.status?.toString().split('.').last ?? 'Unknown'),
                  _buildSimpleInfoRow('Total Time', TimeHelpers.formatTime(timer.totalTime ?? 0)),
                  _buildSimpleInfoRow('Elapsed Time', TimeHelpers.formatTime(timer.elapsedTime ?? 0)),
                  _buildSimpleInfoRow('Remaining Time', TimeHelpers.formatTime((timer.totalTime ?? 0) - (timer.elapsedTime ?? 0))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '$label: $value',
              style: AppTypography.body1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: AppTypography.body2,
          ),
          Text(
            value,
            style: AppTypography.body1,
          ),
        ],
      ),
    );
  }

  void _handlePlayPause(timer_model.Timer timer) {
    final bloc = context.read<TimerBloc>();
    if (timer.isRunning) {
      bloc.add(PauseTimer(id: timer.id));
    } else {
      bloc.add(StartTimer(id: timer.id));
    }
  }

  void _handleStop(timer_model.Timer timer) {
    final bloc = context.read<TimerBloc>();
    bloc.add(StopTimer(id: timer.id));
  }
} 