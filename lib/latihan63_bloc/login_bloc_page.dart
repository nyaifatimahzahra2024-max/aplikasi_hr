import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';
import 'auth_state.dart';
import 'home_bloc_page.dart';

class LoginBlocPage extends StatefulWidget {
  const LoginBlocPage({super.key});

  @override
  State<LoginBlocPage> createState() => _LoginBlocPageState();
}

class _LoginBlocPageState extends State<LoginBlocPage> {
  final _emailController = TextEditingController(text: 'admin@company.com');
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login (Cubit)')),
      body: BlocConsumer<AuthCubit, AuthState>(
        // listener: efek samping, dipanggil sekali per perubahan state
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeBlocPage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.pesan),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        // builder: membangun UI sesuai state
        builder: (context, state) {
          final loading = state is AuthLoading;
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: loading
                    ? null
                    : () => context.read<AuthCubit>().login(
                          _emailController.text.trim(),
                          _passwordController.text,
                        ),
                child: Text(loading ? 'Memproses...' : 'Masuk'),
              ),
              if (loading) ...[
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
              const SizedBox(height: 16),
              const Text('Akun uji: admin@company.com / admin123'),
            ],
          );
        },
      ),
    );
  }
}