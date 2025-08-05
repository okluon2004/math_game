class Lesson {
  final String id;
  final String classId;
  final String title;
  final String type;
  final String level;
  final List<String> questions;

  Lesson({
    required this.id,
    required this.classId,
    required this.title,
    required this.type,
    required this.level,
    required this.questions,
  });
}