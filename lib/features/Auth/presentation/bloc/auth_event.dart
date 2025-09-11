part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogoutPressed extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class CheckEmail extends AuthEvent {
  final String email;

  const CheckEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class SingUpButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final Map<String, dynamic>? user;

  const SingUpButtonPressed({
    required this.email,
    required this.password,
    this.user,
  });

  @override
  List<Object> get props => [email, password];
}

class GetCurrentUser extends AuthEvent {
  final String email;

  const GetCurrentUser({required this.email});

  @override
  List<Object> get props => [email];
}
