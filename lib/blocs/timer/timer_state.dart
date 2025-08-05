import 'package:equatable/equatable.dart';
import '../../models/timer.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object?> get props => [];
}

class TimerInitial extends TimerState {
  const TimerInitial();
}

class TimerLoading extends TimerState {
  const TimerLoading();
}

class TimerLoaded extends TimerState {
  final List<Timer> timers;
  final Timer? runningTimer;

  const TimerLoaded({
    required this.timers,
    this.runningTimer,
  });

  TimerLoaded copyWith({
    List<Timer>? timers,
    Timer? runningTimer,
  }) {
    return TimerLoaded(
      timers: timers ?? this.timers,
      runningTimer: runningTimer ?? this.runningTimer,
    );
  }

  @override
  List<Object?> get props => [timers, runningTimer];
}

class TimerError extends TimerState {
  final String message;

  const TimerError({required this.message});

  @override
  List<Object?> get props => [message];
} 