import 'package:cloud_firestore/cloud_firestore.dart';
class Comment {
  final String commentId;
  final String commenterId;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.commentId,
    required this.commenterId,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> data, String id) {
    return Comment(
      commentId: id,
      commenterId: data['commenterId'],
      content: data['content'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commenterId': commenterId,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
