class AnswerOptionModel {
  final String id;
  final String text;
  final int points;

  const AnswerOptionModel({
    required this.id,
    required this.text,
    required this.points,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      points: json['points'] as int,
    );
  }
}
