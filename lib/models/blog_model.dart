
class Blog {
  final String blogId;
  final String authorId;
  final String authorName;
  final String title;
  final String content;
  final DateTime timestamp;
  final List<String> likes;

  Blog({
    required this.blogId,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
  });

  factory Blog.fromMap(Map<String, dynamic> map, String id) {
    return Blog(
      blogId: id,
      authorId: map['authorId'],
      authorName: map['authorName'],
      title: map['title'],
      content: map['content'],
      timestamp: map['timestamp'].toDate(),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
    };
  }
}
