import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.username = "",
    this.email = "",
    this.token = "",
    this.isLoading = false,
  });

  final bool isLoading;
  final String username;
  final String email;
  final String token;

  @override
  List<Object> get props => [isLoading, username, email, token];

  AuthState copyWith({
    bool? isLoading,
    String? username,
    String? email,
    String? token,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      username: username ?? this.username,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  @override
  bool get stringify => true;
}
