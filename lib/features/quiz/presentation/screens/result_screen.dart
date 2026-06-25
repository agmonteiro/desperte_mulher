import 'package:flutter/material.dart';

import '../controllers/quiz_controller.dart';

class ResultScreen extends StatelessWidget {
  final QuizController controller;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.controller,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final threatLevel = controller.threatLevel;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Resultado final',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  threatLevel.label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  threatLevel.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: onRestart,
                  child: const Text('Reiniciar formulário'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
