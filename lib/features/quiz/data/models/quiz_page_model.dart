import 'question_model.dart';

class QuizPageModel {
  final String id;
  final String title;
  final String description;
  final List<QuestionModel> questions;

  const QuizPageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory QuizPageModel.fromJson(Map<String, dynamic> json) {
    return QuizPageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
