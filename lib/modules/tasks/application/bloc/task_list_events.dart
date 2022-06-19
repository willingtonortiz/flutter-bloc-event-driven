import 'package:blocevents/core/domain/models/app_event.dart';

abstract class TaskListEvent extends AppEvent {}

class TaskListRequested extends TaskListEvent {}

class TaskListRequestCompleted extends TaskListEvent {}

class TaskListRequestFailed extends TaskListEvent {}
