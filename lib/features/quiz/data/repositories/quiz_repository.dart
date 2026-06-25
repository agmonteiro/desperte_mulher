import '../models/quiz_page_model.dart';

abstract class QuizRepository {
  Future<List<QuizPageModel>> getPages();
}
