class Comment {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.replies = const [],
  });
}