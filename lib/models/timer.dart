import 'package:equatable/equatable.dart';
import 'project.dart';

enum TimerStatus { running, paused, completed, stopped }

class Timer extends Equatable {
  final String id;
  final String title;
  final String description;
  final Project project;
  final String deadline;
  final bool isFavorite;
  final bool isRunning;
  final int elapsedTime;
  final int totalTime;
  final TimerStatus status;

  const Timer({
    required this.id,
    required this.title,
    required this.description,
    required this.project,
    required this.deadline,
    required this.isFavorite,
    required this.isRunning,
    required this.elapsedTime,
    required this.totalTime,
    required this.status,
  });

  Timer copyWith({
    String? id,
    String? title,
    String? description,
    Project? project,
    String? deadline,
    bool? isFavorite,
    bool? isRunning,
    int? elapsedTime,
    int? totalTime,
    TimerStatus? status,
  }) {
    return Timer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      project: project ?? this.project,
      deadline: deadline ?? this.deadline,
      isFavorite: isFavorite ?? this.isFavorite,
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      totalTime: totalTime ?? this.totalTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        project,
        deadline,
        isFavorite,
        isRunning,
        elapsedTime,
        totalTime,
        status,
      ];
} 