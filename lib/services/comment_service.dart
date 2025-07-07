import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment_model.dart';

class CommentService {
  final _blogsCollection = FirebaseFirestore.instance.collection('blogs');

  Future<void> addComment(String blogId, CommentModel comment) async {
    await _blogsCollection
        .doc(blogId)
        .collection('comments')
        .doc(comment.commentId)
        .set(comment.toMap());
  }

  Future<void> deleteComment(String blogId, String commentId) async {
    await _blogsCollection.doc(blogId).collection('comments').doc(commentId).delete();
  }

  Stream<List<CommentModel>> getComments(String blogId) {
    return _blogsCollection
        .doc(blogId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CommentModel.fromMap(doc.data())).toList());
  }
}