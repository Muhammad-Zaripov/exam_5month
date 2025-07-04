import 'package:exam_5month/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final numberController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('Sign up', style: TextStyle(fontSize: 50)),
            const SizedBox(height: 100),
            CustomFormField(
              inputType: InputType.phone,
              controller: numberController,
              label: 'Enter your phone number',
            ),
            const SizedBox(height: 100),
            CustomFormField(
              inputType: InputType.password,
              controller: passwordController,
              label: 'Enter your password',
            ),
            const SizedBox(height: 100),
            CustomFormField(
              inputType: InputType.password,
              controller: confirmPasswordController,
              label: 'Confirm your password',
            ),
            const SizedBox(height: 80),
            Container(
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1, color: Color(0xFF757575)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Agree to terms',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
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
            const SizedBox(height: 100),
            Row(
              children: const [
                Expanded(child: Divider(thickness: 2)),
                SizedBox(width: 20),
                Text(
                  'or',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                Expanded(child: Divider(thickness: 2)),
              ],
            ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  'Continue with Google',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
