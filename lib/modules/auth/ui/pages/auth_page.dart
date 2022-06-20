import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

import 'package:blocevents/core/domain/domain.dart';
import 'package:blocevents/core/application/application.dart';
import 'package:blocevents/modules/auth/application/application.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: Modular.get<AuthBloc>()),
        ],
        child: BlocListener<EventBloc, AppEvent>(
          bloc: Modular.get<EventBloc>(),
          listener: (context, state) {
            if (state is LoggedIn) {
              Modular.to.navigate('/tasks');
            }
          },
          child: const AuthView(),
        ),
      ),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: Modular.get<AuthBloc>(),
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }

          return ElevatedButton(
            onPressed: () => Modular.get<AuthBloc>().add(LogIn()),
            child: const Text('LogIn'),
          );
        },
      ),
    );
  }
}
