
import 'package:flutter/material.dart';
import '../../models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final bool canDelete;
  final VoidCallback onDelete;

  const CommentTile({
    super.key,
    required this.comment,
    required this.canDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.content),
      subtitle: Text('by ${comment.commenterId}'),
      trailing: canDelete
          ? IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            )
          : null,
    );
  }
}
