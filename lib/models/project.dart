import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String code;
  final String name;

  const Project({
    required this.id,
    required this.code,
    required this.name,
  });

  Project copyWith({
    String? id,
    String? code,
    String? name,
  }) {
    return Project(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, code, name];
} 