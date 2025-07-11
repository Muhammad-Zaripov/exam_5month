import 'package:exam_5month/features/auth/data/repositories/auth_local_repository.dart';
import 'package:exam_5month/features/history/presentation/screens/history_screen.dart';
import 'package:flutter/material.dart';
import '../../../auth/presentation/screens/welcome_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthLocalDatasource authRepositories = AuthLocalDatasource();
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
              authRepositories.removeToken();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (cxt) => WelcomeScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (cxt) => HistoryScreen()),
              );
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}
