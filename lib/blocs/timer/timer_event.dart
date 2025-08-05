import 'package:equatable/equatable.dart';
import '../../models/timer.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class AddTimer extends TimerEvent {
  final String title;
  final String description;
  final String projectId;
  final String deadline;
  final bool isFavorite;

  const AddTimer({
    required this.title,
    required this.description,
    required this.projectId,
    required this.deadline,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [title, description, projectId, deadline, isFavorite];
}

class UpdateTimer extends TimerEvent {
  final String id;
  final Map<String, dynamic> updates;

  const UpdateTimer({
    required this.id,
    required this.updates,
  });

  @override
  List<Object?> get props => [id, updates];
}

class DeleteTimer extends TimerEvent {
  final String id;

  const DeleteTimer({required this.id});

  @override
  List<Object?> get props => [id];
}

class StartTimer extends TimerEvent {
  final String id;

  const StartTimer({required this.id});

  @override
  List<Object?> get props => [id];
}

class PauseTimer extends TimerEvent {
  final String id;

  const PauseTimer({required this.id});

  @override
  List<Object?> get props => [id];
}

class StopTimer extends TimerEvent {
  final String id;

  const StopTimer({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateElapsedTime extends TimerEvent {
  final String id;
  final int elapsedTime;

  const UpdateElapsedTime({
    required this.id,
    required this.elapsedTime,
  });

  @override
  List<Object?> get props => [id, elapsedTime];
} 