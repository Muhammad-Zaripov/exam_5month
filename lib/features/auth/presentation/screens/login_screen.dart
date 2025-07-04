import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_5month/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam_5month/features/auth/presentation/screens/register_screen.dart';
import 'package:exam_5month/features/auth/presentation/widgets/custom_text_field_widget.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../data/models/auth_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  void _login() {
    if (_globalKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignInRequested(
          AuthModel(
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => const RestaurantHomeScreen()),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQueryW >= 700 ? 140 : 20,
          ),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Log in', style: TextStyle(fontSize: 50)),
                const SizedBox(height: 100),
                CustomFormField(
                  inputType: InputType.email,
                  controller: emailController,
                  label: 'Enter your email',
                ),
                const SizedBox(height: 30),
                CustomFormField(
                  inputType: InputType.password,
                  controller: passwordController,
                  label: 'Enter your password',
                ),
                const SizedBox(height: 80),
                GestureDetector(
                  onTap: _login,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                        colors: [Color(0xFF2E9055), Color(0xFF35C56E)],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(fontSize: 20, color: Color(0xFF757575)),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF289E56),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
