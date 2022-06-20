import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocevents/core/application/bloc/bloc.dart';
import 'package:blocevents/modules/auth/application/bloc/bloc.dart';

class AuthBloc extends Bloc<AuthActions, AuthState> {
  AuthBloc({
    required this.eventBloc,
  }) : super(const AuthState()) {
    on<LogIn>(logIn);
    on<LogOut>(logOut);
  }

  final EventBloc eventBloc;

  Future<void> logIn(
    LogIn action,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    eventBloc.addEvent(LogInStarted());

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      username: 'sasaki',
      email: 'sasaki@haise.com',
      token: 'sasaki:sasaki@haise.com',
    ));
    eventBloc.addEvent(LoggedIn());
  }

  Future<void> logOut(
    LogOut action,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    eventBloc.addEvent(LogOutStarted());

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      username: '',
      email: '',
      token: '',
    ));
    eventBloc.addEvent(LoggedOut());
  }
}
