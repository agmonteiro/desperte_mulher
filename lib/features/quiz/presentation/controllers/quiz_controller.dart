import 'package:flutter/foundation.dart';

import '../../../../core/utils/threat_level.dart';
import '../../data/models/quiz_page_model.dart';
import '../../data/repositories/quiz_repository.dart';

class QuizController extends ChangeNotifier {
  final QuizRepository repository;

  QuizController({required this.repository});

  bool isLoading = true;
  String? errorMessage;

  List<QuizPageModel> pages = [];
  int currentPageIndex = 0;

  final Map<String, String> _selectedAnswers = {};

  Future<void> loadQuiz() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      pages = await repository.getPages();
    } catch (e) {
      errorMessage = 'Falha ao carregar as perguntas.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setCurrentPage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void showResult() {
    currentPageIndex = pages.length;
    notifyListeners();
  }

  void reset() {
    _selectedAnswers.clear();
    currentPageIndex = 0;
    notifyListeners();
  }

  void selectAnswer({
    required String pageId,
    required String questionId,
    required String answerId,
  }) {
    final key = '$pageId::$questionId';
    _selectedAnswers[key] = answerId;
    notifyListeners();
  }

  bool isSelected({
    required String pageId,
    required String questionId,
    required String answerId,
  }) {
    final key = '$pageId::$questionId';
    return _selectedAnswers[key] == answerId;
  }

  bool isQuestionAnswered({
    required String pageId,
    required String questionId,
  }) {
    final key = '$pageId::$questionId';
    return _selectedAnswers.containsKey(key);
  }

  bool isCurrentPageValid() {
    if (pages.isEmpty || currentPageIndex < 0 || currentPageIndex >= pages.length) {
      return false;
    }

    final page = pages[currentPageIndex];
    return page.questions.every(
      (q) => isQuestionAnswered(pageId: page.id, questionId: q.id),
    );
  }

  int get totalPoints {
    int sum = 0;

    for (final page in pages) {
      for (final question in page.questions) {
        final key = '${page.id}::${question.id}';
        final selectedId = _selectedAnswers[key];
        if (selectedId == null) continue;

        final answer = question.answers
            .where((a) => a.id == selectedId)
            .cast<dynamic>()
            .firstOrNull;
        if (answer != null) {
          sum += answer.points as int;
        }
      }
    }

    return sum;
  }

  int get selectedAnswersCount => _selectedAnswers.length;

  ThreatLevelInfo get threatLevel => threatLevelFromPoints(totalPoints);
}
