import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/timer.dart' as timer_model;
import '../../models/project.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _periodicTimer;
  timer_model.Timer? _runningTimer;

  // Sample projects data
  final List<Project> _projects = [
    const Project(id: '1', code: 'SO056', name: 'Booqio V2'),
    const Project(id: '2', code: 'SO057', name: 'Booqio V3'),
    const Project(id: '3', code: 'SO058', name: 'Mobile App'),
    const Project(id: '4', code: 'SO059', name: 'Web Dashboard'),
  ];

  TimerBloc() : super(const TimerInitial()) {
    on<AddTimer>(_onAddTimer);
    on<UpdateTimer>(_onUpdateTimer);
    on<DeleteTimer>(_onDeleteTimer);
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<StopTimer>(_onStopTimer);
    on<UpdateElapsedTime>(_onUpdateElapsedTime);

    // Start timer tick
    _startTimerTick();
    
    // Add some sample timers for testing
    _addSampleTimers();
  }

  void _startTimerTick() {
    _periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_runningTimer != null) {
        add(UpdateElapsedTime(
          id: _runningTimer!.id,
          elapsedTime: _runningTimer!.elapsedTime + 1,
        ));
      }
    });
  }

  void _onAddTimer(AddTimer event, Emitter<TimerState> emit) {
    try {
      final project = _projects.firstWhere((p) => p.id == event.projectId);
      
      final newTimer = timer_model.Timer(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        description: event.description,
        project: project,
        deadline: event.deadline,
        isFavorite: event.isFavorite,
        isRunning: false,
        elapsedTime: 0,
        totalTime: 0,
        status: timer_model.TimerStatus.stopped,
      );

      final currentState = state;
      if (currentState is TimerLoaded) {
        emit(TimerLoaded(
          timers: [...currentState.timers, newTimer],
          runningTimer: currentState.runningTimer,
        ));
      } else {
        emit(TimerLoaded(
          timers: [newTimer],
          runningTimer: null,
        ));
      }
    } catch (e) {
      emit(TimerError(message: 'Failed to add timer: $e'));
    }
  }

  void _onUpdateTimer(UpdateTimer event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == event.id) {
          return timer.copyWith(
            title: event.updates['title'] ?? timer.title,
            description: event.updates['description'] ?? timer.description,
            deadline: event.updates['deadline'] ?? timer.deadline,
            isFavorite: event.updates['isFavorite'] ?? timer.isFavorite,
            elapsedTime: event.updates['elapsedTime'] ?? timer.elapsedTime,
            totalTime: event.updates['totalTime'] ?? timer.totalTime,
            isRunning: event.updates['isRunning'] ?? timer.isRunning,
            status: event.updates['status'] ?? timer.status,
          );
        }
        return timer;
      }).toList();

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  void _onDeleteTimer(DeleteTimer event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      final updatedTimers = currentState.timers.where((timer) => timer.id != event.id).toList();
      
      // If we're deleting the running timer, stop it
      if (_runningTimer?.id == event.id) {
        _runningTimer = null;
      }

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      // Stop any currently running timer
      if (_runningTimer != null) {
              final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == _runningTimer!.id) {
          return timer.copyWith(
            isRunning: false,
            status: timer_model.TimerStatus.paused,
          );
        }
        return timer;
      }).toList();

        _runningTimer = null;
        emit(TimerLoaded(
          timers: updatedTimers,
          runningTimer: null,
        ));
      }

      // Start the new timer
      final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == event.id) {
          final updatedTimer = timer.copyWith(
            isRunning: true,
            status: timer_model.TimerStatus.running,
          );
          _runningTimer = updatedTimer;
          return updatedTimer;
        }
        return timer;
      }).toList();

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  void _onPauseTimer(PauseTimer event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == event.id) {
          return timer.copyWith(
            isRunning: false,
            status: timer_model.TimerStatus.paused,
          );
        }
        return timer;
      }).toList();

      if (_runningTimer?.id == event.id) {
        _runningTimer = null;
      }

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  void _onStopTimer(StopTimer event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == event.id) {
          return timer.copyWith(
            isRunning: false,
            status: timer_model.TimerStatus.completed,
          );
        }
        return timer;
      }).toList();

      if (_runningTimer?.id == event.id) {
        _runningTimer = null;
      }

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  void _onUpdateElapsedTime(UpdateElapsedTime event, Emitter<TimerState> emit) {
    final currentState = state;
    if (currentState is TimerLoaded) {
      final updatedTimers = currentState.timers.map((timer) {
        if (timer.id == event.id) {
          final updatedTimer = timer.copyWith(elapsedTime: event.elapsedTime);
          if (timer.isRunning) {
            _runningTimer = updatedTimer;
          }
          return updatedTimer;
        }
        return timer;
      }).toList();

      emit(TimerLoaded(
        timers: updatedTimers,
        runningTimer: _runningTimer,
      ));
    }
  }

  List<Project> get projects => _projects;

  void _addSampleTimers() {
    // Add sample timers for testing
    add(AddTimer(
      title: 'Design Review',
      description: 'Review the new UI designs for the mobile app',
      projectId: '1',
      deadline: '2024-01-15',
      isFavorite: true,
    ));
    
    add(AddTimer(
      title: 'Code Implementation',
      description: 'Implement the timer functionality',
      projectId: '2',
      deadline: '2024-01-20',
      isFavorite: false,
    ));
    
    add(AddTimer(
      title: 'Testing',
      description: 'Test the timer application thoroughly',
      projectId: '3',
      deadline: '2024-01-25',
      isFavorite: true,
    ));
  }

  @override
  Future<void> close() {
    _periodicTimer?.cancel();
    return super.close();
  }
} 