import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

import 'package:blocevents/core/application/bloc/bloc.dart';
import 'package:blocevents/core/domain/models/models.dart';
import 'package:blocevents/modules/auth/application/bloc/bloc.dart';
import 'package:blocevents/modules/tasks/application/bloc/bloc.dart';

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
              eventBloc: Modular.get<EventBloc>(),
              authBloc: Modular.get<AuthBloc>(),
            ),
          ),
          BlocProvider<AuthBloc>.value(value: Modular.get<AuthBloc>()),
        ],
        child: BlocListener<EventBloc, AppEvent>(
          bloc: Modular.get<EventBloc>(),
          listener: (context, state) {
            if (state is LoggedOut) {
              Modular.to.navigate('/');
            }
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
            onPressed: () => context.read<AuthBloc>().add(LogOut()),
            child: const Text('Log out'),
          ),
          ElevatedButton(
            onPressed: () => context.read<TaskListBloc>().add(LoadTaskList()),
            child: const Text('Load tasks'),
          ),
        ],
      ),
    );
  }
}
