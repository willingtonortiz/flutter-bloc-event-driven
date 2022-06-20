import 'package:blocevents/core/domain/domain.dart';

class AuthEvent extends AppEvent {}

class LogInStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LogOutStarted extends AuthEvent {}

class LoggedOut extends AuthEvent {}
