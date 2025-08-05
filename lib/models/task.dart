import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final String projectId;

  const Task({
    required this.id,
    required this.name,
    required this.projectId,
  });

  Task copyWith({
    String? id,
    String? name,
    String? projectId,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
    );
  }

  @override
  List<Object?> get props => [id, name, projectId];
} 