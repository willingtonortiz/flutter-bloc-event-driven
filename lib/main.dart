import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:blocevents/app_module.dart';
import 'package:blocevents/app_widget.dart';

void main() {
  Modular.setInitialRoute('/');

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
  // const MyApp()
}
