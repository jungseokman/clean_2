class Note {
  final String title;
  final String content;
  final int color;
  final int timestamp;
  final int? id;
  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.timestamp,
    this.id,
  });
}
