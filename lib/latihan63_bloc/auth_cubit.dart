import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const Unauthenticated());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2)); // simulasi API
    if (isClosed) return; // Cubit sudah ditutup

    if (email == 'admin@company.com' && password == 'admin123') {
      emit(const Authenticated(nama: 'Admin HR', email: 'admin@company.com'));
    } else {
      emit(const AuthError('Email atau password salah'));
    }
  }

  void logout() => emit(const Unauthenticated());
}