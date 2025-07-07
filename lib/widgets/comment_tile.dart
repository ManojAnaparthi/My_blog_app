import 'package:flutter/material.dart';
import '../models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback? onDelete;
  final bool canDelete;

  const CommentTile({required this.comment, this.onDelete, this.canDelete = false, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(comment.commenterPic)),
      title: Text(comment.commenterName),
      subtitle: Text(comment.content),
      trailing: canDelete ? IconButton(icon: const Icon(Icons.delete), onPressed: onDelete) : null,
    );
  }
}