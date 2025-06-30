
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/comment_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/comment_model.dart';
import '../../widgets/comment_tile.dart';

class CommentScreen extends StatefulWidget {
  final String blogId;
  const CommentScreen({super.key, required this.blogId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CommentProvider>(context, listen: false)
        .loadComments(widget.blogId);
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final comments = commentProvider.comments;

    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: comments.isEmpty
                ? const Center(child: Text('No comments yet'))
                : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentTile(
                        comment: comment,
                        canDelete: comment.commenterId ==
                                authProvider.user!.uid ||
                            commentProvider.isBlogOwner,
                        onDelete: () async {
                          await commentProvider.deleteComment(
                              widget.blogId, comment.commentId);
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Add a comment...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (_controller.text.trim().isNotEmpty) {
                      await commentProvider.addComment(
                        widget.blogId,
                        _controller.text.trim(),
                        authProvider.user!.uid,
                      );
                      _controller.clear();
                    }
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
