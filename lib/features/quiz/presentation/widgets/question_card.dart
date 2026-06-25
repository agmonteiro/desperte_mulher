import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';
import '../controllers/quiz_controller.dart';
import 'answer_tile.dart';

class QuestionCard extends StatelessWidget {
  final String pageId;
  final QuestionModel question;
  final QuizController controller;

  const QuestionCard({
    super.key,
    required this.pageId,
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selecione apenas uma opção.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.75),
                      ),
                ),
                const SizedBox(height: 10),
                ...question.answers.map((answer) {
                  final selected = controller.isSelected(
                    pageId: pageId,
                    questionId: question.id,
                    answerId: answer.id,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AnswerTile(
                      text: answer.text,
                      selected: selected,
                      onTap: () {
                        controller.selectAnswer(
                          pageId: pageId,
                          questionId: question.id,
                          answerId: answer.id,
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
