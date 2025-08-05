import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/timer/timer_bloc.dart';
import '../../blocs/timer/timer_event.dart';
import '../../models/timer.dart' as timer_model;
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class TimerCard extends StatelessWidget {
  final timer_model.Timer timer;

  const TimerCard({
    super.key,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: () => context.go('/task/${timer.id}'),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Left side - Timer info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and checkbox
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.borderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.xs),
                          ),
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.textTertiary,
                              borderRadius: BorderRadius.circular(AppRadius.xs),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            timer.title,
                            style: AppTypography.body1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    
                    // Project info
                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            '${timer.project.code} - ${timer.project.name}',
                            style: AppTypography.body2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    // Deadline info
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Deadline ${timer.deadline}',
                          style: AppTypography.body2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Right side - Timer display and controls
              Column(
                children: [
                  // Timer display
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundHover,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      TimeHelpers.formatTime(timer.elapsedTime),
                      style: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  
                  // Play/Pause button
                  IconButton(
                    onPressed: () => _handlePlayPause(context),
                    icon: Icon(
                      timer.isRunning ? Icons.pause : Icons.play_arrow,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.all(AppSpacing.sm),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePlayPause(BuildContext context) {
    final bloc = context.read<TimerBloc>();
    if (timer.isRunning) {
      bloc.add(PauseTimer(id: timer.id));
    } else {
      bloc.add(StartTimer(id: timer.id));
    }
  }
} 