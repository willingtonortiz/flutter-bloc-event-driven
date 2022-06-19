// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:blocevents/modules/tasks/domain/models/task.dart';

class TaskListState extends Equatable {
  const TaskListState({
    this.tasks = const [],
    this.isLoading = false,
  });

  final List<Task> tasks;
  final bool isLoading;

  TaskListState copyWith({
    List<Task>? tasks,
    bool? isLoading,
  }) {
    return TaskListState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [tasks, isLoading];
}
