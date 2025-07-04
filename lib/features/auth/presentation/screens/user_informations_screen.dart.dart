import 'package:flutter/material.dart';
import '../../data/auth_repository_datasurce.dart';
import '../../data/repositories/auth_local_repository.dart';
import 'welcome_screen.dart';

class UserInformationsScreen extends StatefulWidget {
  const UserInformationsScreen({super.key});
  @override
  State<UserInformationsScreen> createState() => _UserInformationsScreenState();
}

class _UserInformationsScreenState extends State<UserInformationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final AuthLocalDatasource _authRepositories = AuthLocalDatasource();

  bool isLoading = false;
  final authRemoteDatasource = AuthRemoteDatasource();

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await authRemoteDatasource.completeProfile(
        nameController.text.trim(),
        phoneController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profil saqlandi!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Xatolik: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Profilni to‘ldirish'),
        actions: [
          IconButton(
            onPressed: () {
              _authRepositories.removeToken();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (cxt) => WelcomeScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Ismingiz'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ism kiriting' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefon raqam'),
                validator: (value) => value == null || value.length < 7
                    ? 'Telefon raqam kiriting'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : saveProfile,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Saqlash'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
