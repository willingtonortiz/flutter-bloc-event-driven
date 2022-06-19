import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocevents/core/application/bloc/global/event_bloc.dart';
import 'package:blocevents/core/domain/models/app_event.dart';

import 'package:blocevents/modules/tasks/application/bloc/task_list_bloc.dart';
import 'package:blocevents/modules/tasks/application/bloc/task_list_actions.dart';
import 'package:blocevents/modules/tasks/application/bloc/task_list_events.dart';
import 'package:blocevents/modules/tasks/application/bloc/task_list_state.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>(
            create: (_) => TaskListBloc(
              eventBloc: context.read<EventBloc>(),
            ),
          ),
        ],
        child: BlocListener<EventBloc, AppEvent>(
          listener: (context, state) {
            if (state is TaskListRequested) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Loading tasks...'),
                ));
            }
            if (state is TaskListRequestCompleted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Tasks loaded'),
                  backgroundColor: Colors.green,
                ));
            }
            if (state is TaskListRequestFailed) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Tasks failed'),
                  backgroundColor: Colors.red,
                ));
            }
          },
          child: const TaskListView(),
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Tasks'),
          const SizedBox(height: 16),
          BlocBuilder<TaskListBloc, TaskListState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }

              return const SizedBox();
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskListBloc>().add(LoadTaskList());
            },
            child: const Text('Load tasks'),
          ),
        ],
      ),
    );
  }
}
