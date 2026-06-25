import 'package:flutter/material.dart';

import '../features/quiz/data/datasources/quiz_mock_datasource.dart';
import '../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../features/quiz/presentation/controllers/quiz_controller.dart';
import '../features/quiz/presentation/screens/quiz_shell_screen.dart';
import 'theme/app_theme.dart';

class DespertaMulherApp extends StatefulWidget {
  const DespertaMulherApp({super.key});

  @override
  State<DespertaMulherApp> createState() => _DespertaMulherAppState();
}

class _DespertaMulherAppState extends State<DespertaMulherApp> {
  late final QuizController controller;

  @override
  void initState() {
    super.initState();
    controller = QuizController(
      repository: QuizRepositoryImpl(QuizMockDataSource()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desperta Mulher',
      theme: buildAppTheme(),
      home: QuizShellScreen(controller: controller),
    );
  }
}
