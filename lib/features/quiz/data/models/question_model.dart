import 'answer_option_model.dart';

class QuestionModel {
  final String id;
  final String text;
  final List<AnswerOptionModel> answers;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
