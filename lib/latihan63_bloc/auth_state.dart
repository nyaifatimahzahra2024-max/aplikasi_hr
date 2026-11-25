import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  const Authenticated({required this.nama, required this.email});

  final String nama;
  final String email;

  @override
  List<Object?> get props => [nama, email];
}

class AuthError extends AuthState {
  const AuthError(this.pesan);

  final String pesan;

  @override
  List<Object?> get props => [pesan];
}