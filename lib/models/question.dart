class Question {
  final String id;
  final String content;
  final List<String> choices;
  final int correctIndex;
  final String type;
  final String level;

  Question({
    required this.id,
    required this.content,
    required this.choices,
    required this.correctIndex,
    required this.type,
    required this.level,
  });
}