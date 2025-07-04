import 'package:exam_5month/features/auth/presentation/screens/register_screen.dart';
import 'package:exam_5month/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final numberController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 130, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('Log in', style: TextStyle(fontSize: 50)),
            SizedBox(height: 100),
            CustomFormField(
              inputType: InputType.phone,
              controller: numberController,
              label: 'Enter your phone number',
            ),
            SizedBox(height: 100),
            CustomFormField(
              inputType: InputType.password,
              controller: passwordController,
              label: 'Enter your password',
            ),
            SizedBox(height: 80),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                  colors: [Color(0xFF2E9055), Color(0xFF35C56E)],
                ),
              ),
              child: Center(
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1, color: Color(0xFF757575)),
                      ),
                    ),
                    Text('Remember me', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: TextStyle(fontSize: 20, color: Color(0xFF757575)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (cxt) => RegisterScreen()),
                      ),
                      child: Text(
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
            SizedBox(height: 100),
            Row(
              spacing: 20,
              children: [
                Expanded(child: Divider(thickness: 2)),
                Text(
                  'or',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Divider(thickness: 2)),
              ],
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: Center(
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
