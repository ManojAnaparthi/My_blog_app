
import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../services/comment_service.dart';

class CommentProvider with ChangeNotifier {
  final CommentService _commentService = CommentService();
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Stream<List<Comment>> getComments(String blogId) {
    return _commentService.getComments(blogId);
  }

  Future<void> addComment(String blogId, Comment comment) async {
    await _commentService.addComment(blogId, comment);
    notifyListeners();
  }

  Future<void> deleteComment(String blogId, String commentId) async {
    await _commentService.deleteComment(blogId, commentId);
    notifyListeners();
  }
}
