
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/blog_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/blog_provider.dart';
import '../comments/comment_screen.dart';
import 'edit_blog_screen.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    final isOwner = authProvider.user?.uid == blog.authorId;
    final isLiked = blog.likes.contains(authProvider.user!.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: isOwner
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditBlogScreen(blog: blog),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await blogProvider.deleteBlog(blog.blogId);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('by ${blog.authorName}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(blog.content),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    blogProvider.toggleLike(blog.blogId, authProvider.user!.uid);
                  },
                ),
                Text('${blog.likes.length} likes'),
                const SizedBox(width: 20),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CommentScreen(blogId: blog.blogId),
                      ),
                    );
                  },
                  icon: const Icon(Icons.comment),
                  label: const Text('Comments'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
