import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../services/comment_service.dart';
import '../../models/comment_model.dart';

class CommentScreen extends StatefulWidget {
  final String blogId;
  final String blogAuthorId;
  const CommentScreen({required this.blogId, required this.blogAuthorId, super.key});
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final commentController = TextEditingController();
  final commentService = CommentService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CommentModel>>(
              stream: commentService.getComments(widget.blogId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final comments = snapshot.data!;
                if (comments.isEmpty) return const Center(child: Text("No comments yet"));
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (ctx, idx) {
                    final comment = comments[idx];
                    final canDelete = comment.commenterId == user.uid || widget.blogAuthorId == user.uid;
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(comment.commenterPic)),
                      title: Text(comment.commenterName),
                      subtitle: Text(comment.content),
                      trailing: canDelete
                          ? IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await commentService.deleteComment(widget.blogId, comment.commentId);
                        },
                      )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: commentController, decoration: const InputDecoration(hintText: "Write a comment..."))),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (commentController.text.trim().isEmpty) return;
                    final comment = CommentModel(
                      commentId: const Uuid().v4(),
                      commenterId: user.uid,
                      commenterName: user.username,
                      commenterPic: user.profilePicUrl,
                      content: commentController.text.trim(),
                      timestamp: DateTime.now(),
                    );
                    await commentService.addComment(widget.blogId, comment);
                    commentController.clear();
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