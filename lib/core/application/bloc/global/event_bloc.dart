import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocevents/core/domain/models/app_event.dart';

class EventBloc extends Cubit<AppEvent> {
  EventBloc() : super(UnsetEvent());

  void addEvent(AppEvent event) {
    log('[Event] ${event.runtimeType.toString()}');
    emit(event);
  }
}
