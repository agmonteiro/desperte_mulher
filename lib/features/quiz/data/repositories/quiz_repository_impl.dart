import '../datasources/quiz_datasource.dart';
import '../models/quiz_page_model.dart';
import 'quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);

  @override
  Future<List<QuizPageModel>> getPages() {
    return dataSource.loadPages();
  }
}
