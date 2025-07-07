import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String blogId;
  final String authorId;
  final String authorName;
  final String authorPic;
  final String title;
  final String content;
  final DateTime timestamp;
  final List<String> likes;

  BlogModel({
    required this.blogId,
    required this.authorId,
    required this.authorName,
    required this.authorPic,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
  });

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blogId'],
      authorId: map['authorId'],
      authorName: map['authorName'],
      authorPic: map['authorPic'] ?? '',
      title: map['title'],
      content: map['content'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blogId': blogId,
      'authorId': authorId,
      'authorName': authorName,
      'authorPic': authorPic,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
    };
  }
}