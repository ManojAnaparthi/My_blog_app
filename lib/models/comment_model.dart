import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commenterPic;
  final String content;
  final DateTime timestamp;

  CommentModel({
    required this.commentId,
    required this.commenterId,
    required this.commenterName,
    required this.commenterPic,
    required this.content,
    required this.timestamp,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'],
      commenterId: map['commenterId'],
      commenterName: map['commenterName'] ?? '',
      commenterPic: map['commenterPic'] ?? '',
      content: map['content'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'commenterId': commenterId,
      'commenterName': commenterName,
      'commenterPic': commenterPic,
      'content': content,
      'timestamp': timestamp,
    };
  }
}