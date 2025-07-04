import 'package:exam_5month/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam_5month/features/auth/presentation/screens/register_screen.dart';
import 'package:exam_5month/features/auth/presentation/screens/start_screen.dart';
import 'package:exam_5month/features/home/presentation/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/home/data/datasources/table_remote_datasource.dart';
import '../features/home/data/repositories/table_repository_impl.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final TableRepository repository = TableRepository(TableRemoteDataSource());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TableBloc(repository)),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(home: StartScreen()),
    );
  }
}
