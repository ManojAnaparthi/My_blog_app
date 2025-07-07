
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/comment_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/comment_service.dart';

class CommentScreen extends StatefulWidget {
  final String blogId;
  final String blogAuthorId;

  const CommentScreen({super.key, required this.blogId, required this.blogAuthorId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentService _commentService = CommentService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: _commentService.getComments(widget.blogId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final comments = snapshot.data!;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      title: Text(comment.content),
                      subtitle: Text(comment.timestamp.toLocal().toString()),
                      trailing: (comment.commenterId == user.uid || widget.blogAuthorId == user.uid)
                          ? IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _commentService.deleteComment(widget.blogId, comment.commentId),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Add a comment...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final newComment = Comment(
                      commentId: '',
                      commenterId: user.uid,
                      content: _controller.text,
                      timestamp: DateTime.now(),
                    );
                    _commentService.addComment(widget.blogId, newComment);
                    _controller.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
