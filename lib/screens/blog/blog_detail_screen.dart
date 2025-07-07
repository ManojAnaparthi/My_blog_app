import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/blog_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/blog_provider.dart';
import '../../screens/comments/comment_screen.dart';
import '../../screens/blog/edit_blog_screen.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogModel blog;
  const BlogDetailScreen({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isOwner = blog.authorId == authProvider.user?.uid;
    final hasLiked = blog.likes.contains(authProvider.user?.uid ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          if (isOwner)
            PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'edit') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EditBlogScreen(blog: blog)));
                } else if (v == 'delete') {
                  await Provider.of<BlogProvider>(context, listen: false).deleteBlog(blog.blogId);
                  Navigator.pop(context);
                }
              },
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(blog.authorPic), radius: 20),
              const SizedBox(width: 8),
              Text(blog.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Text(blog.content, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                icon: Icon(hasLiked ? Icons.favorite : Icons.favorite_border, color: hasLiked ? Colors.red : null),
                onPressed: () {
                  final provider = Provider.of<BlogProvider>(context, listen: false);
                  if (hasLiked) {
                    provider.unlikeBlog(blog.blogId, authProvider.user!.uid);
                  } else {
                    provider.likeBlog(blog.blogId, authProvider.user!.uid);
                  }
                },
              ),
              Text('${blog.likes.length} likes'),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommentScreen(blogId: blog.blogId, blogAuthorId: blog.authorId))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}