import 'package:exam_5month/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../../../auth/data/repositories/auth_local_repository.dart';

class HeaderWidget extends StatelessWidget {
  final AuthLocalDatasource _authRepositories = AuthLocalDatasource();
  HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E9055), Color(0xFF35C56E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Restoran boshqaruvi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _authRepositories.removeToken();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (cxt) => WelcomeScreen()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
