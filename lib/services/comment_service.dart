
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment_model.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Comment>> getComments(String blogId) {
    return _firestore
      .collection('blogs')
      .doc(blogId)
      .collection('comments')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => Comment.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addComment(String blogId, Comment comment) async {
    await _firestore
      .collection('blogs')
      .doc(blogId)
      .collection('comments')
      .add(comment.toMap());
  }

  Future<void> deleteComment(String blogId, String commentId) async {
    await _firestore
      .collection('blogs')
      .doc(blogId)
      .collection('comments')
      .doc(commentId)
      .delete();
  }
}
