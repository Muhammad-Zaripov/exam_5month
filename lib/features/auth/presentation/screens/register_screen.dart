import 'package:exam_5month/features/auth/data/models/user_model.dart';
import 'package:exam_5month/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam_5month/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:exam_5month/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  void _register() {
    if (_globalKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpRequested(
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQueryW >= 700 ? 140 : 20,
        ),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign up', style: TextStyle(fontSize: 50)),
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
              BlocConsumer<AuthBloc, AuthState>(
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
                      MaterialPageRoute(
                        builder: (cxt) => const RestaurantHomeScreen(),
                      ),
                    );
                  }
                },

                builder: (context, state) {
                  return GestureDetector(
                    onTap: _register,
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
                          'Sign up',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: const [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20, color: Color(0xFF757575)),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Color(0xFF289E56)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
