
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

  factory Comment.fromMap(Map<String, dynamic> map, String id) {
    return Comment(
      commentId: id,
      commenterId: map['commenterId'],
      content: map['content'],
      timestamp: map['timestamp'].toDate(),
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
