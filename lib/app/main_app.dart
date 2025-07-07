import 'package:exam_5month/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam_5month/features/auth/presentation/screens/start_screen.dart';
import 'package:exam_5month/features/history/presentation/bloc/history_bloc.dart';
import 'package:exam_5month/features/home/presentation/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/history/data/repositories/history_repository.dart';
import '../features/home/data/datasources/table_remote_datasource.dart';
import '../features/home/data/repositories/table_repository_impl.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TableRepository tableRepository = TableRepository(
      TableRemoteDataSource(),
    );
    final HistoryRepository historyRepository = HistoryRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TableBloc(tableRepository)),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HistoryBloc(historyRepository)),
      ],
      child: const MaterialApp(home: StartScreen()),
    );
  }
}
