import 'package:flutter_modular/flutter_modular.dart';

import 'package:blocevents/core/application/bloc/bloc.dart';
import 'package:blocevents/modules/auth/application/application.dart';
import 'package:blocevents/modules/auth/ui/ui.dart';
import 'package:blocevents/modules/tasks/ui/ui.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((_) => EventBloc()),
        Bind.singleton(
          (i) => AuthBloc(
            eventBloc: i.get<EventBloc>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const AuthPage()),
        ChildRoute('/tasks', child: (_, __) => const TasksListPage()),
      ];
}
