import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Blog.fromMap(Map<String, dynamic> data, String id) {
    return Blog(
      blogId: id,
      authorId: data['authorId'],
      authorName: data['authorName'],
      title: data['title'],
      content: data['content'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      likes: List<String>.from(data['likes']),
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
