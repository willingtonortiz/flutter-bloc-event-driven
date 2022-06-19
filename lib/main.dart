import 'package:blocevents/core/application/bloc/global/event_bloc.dart';
import 'package:blocevents/modules/tasks/ui/pages/task_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<EventBloc>(
            create: (_) => EventBloc(),
          ),
        ],
        child: const TasksListPage(),
      ),
    );
  }
}
