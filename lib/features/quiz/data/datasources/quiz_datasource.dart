import '../models/quiz_page_model.dart';

abstract class QuizDataSource {
  Future<List<QuizPageModel>> loadPages();
}
