import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/core/api_client.dart';
import 'package:todo_app_bloc/data/data_sources/task_api.dart';
import 'package:todo_app_bloc/data/repositories/task_repository.dart';
import 'package:todo_app_bloc/logic/task/task_bloc.dart';
import 'package:todo_app_bloc/logic/task/task_event.dart';
import 'package:todo_app_bloc/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(
          create: (_) => ApiClient(
            "https://68fc7a1d96f6ff19b9f53c95.mockapi.io/api/v1",
          ),
        ),
        RepositoryProvider<TaskApi>(
          create: (context) => TaskApi(context.read<ApiClient>()),
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => TaskRepository(context.read<TaskApi>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(
              context.read<TaskRepository>(),
            )..add(LoadTasks()),
          ),
        ],
        child: MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
