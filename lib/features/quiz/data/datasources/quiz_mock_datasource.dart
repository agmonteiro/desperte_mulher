import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/quiz_page_model.dart';
import 'quiz_datasource.dart';

class QuizMockDataSource implements QuizDataSource {
  @override
  Future<List<QuizPageModel>> loadPages() async {
    final pages = <QuizPageModel>[];

    for (final path in AppConstants.quizAssetPaths) {
      final raw = await rootBundle.loadString(path);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      pages.add(QuizPageModel.fromJson(decoded));
    }

    return pages;
  }
}
