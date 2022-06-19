import 'dart:math';

import 'package:blocevents/modules/tasks/application/bloc/task_list_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocevents/core/application/bloc/global/event_bloc.dart';

import 'package:blocevents/modules/tasks/domain/models/task.dart';
import 'package:blocevents/modules/tasks/application/bloc/task_list_actions.dart';
import 'package:blocevents/modules/tasks/application/bloc/task_list_state.dart';

class TaskListBloc extends Bloc<TaskListAction, TaskListState> {
  TaskListBloc({
    required this.eventBloc,
  }) : super(const TaskListState()) {
    on<LoadTaskList>(loadTaskList);
  }

  final EventBloc eventBloc;

  Future<void> loadTaskList(
    LoadTaskList action,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    eventBloc.addEvent(TaskListRequested());
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      final random = Random();
      if (random.nextBool()) {
        throw Exception('Failed to load tasks');
      }

      emit(state.copyWith(
        tasks: [
          Task(id: '01', title: 'Title 1'),
          Task(id: '02', title: 'Title 2'),
          Task(id: '03', title: 'Title 3'),
        ],
        isLoading: false,
      ));
      eventBloc.addEvent(TaskListRequestCompleted());
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      eventBloc.addEvent(TaskListRequestFailed());
    }
  }
}
