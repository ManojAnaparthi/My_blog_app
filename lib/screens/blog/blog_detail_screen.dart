
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/blog_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/blog_provider.dart';
import '../comments/comment_screen.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final blogProvider = Provider.of<BlogProvider>(context);
    final isAuthor = auth.user!.uid == blog.authorId;
    final isLiked = blog.likes.contains(auth.user!.uid);

    return Scaffold(
      appBar: AppBar(title: Text(blog.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blog.content),
            const SizedBox(height: 16),
            Text("By ${blog.authorName}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : null),
                  onPressed: () {
                    blogProvider.toggleLike(blog.blogId, auth.user!.uid);
                  },
                ),
                Text('${blog.likes.length} likes'),
                const Spacer(),
                if (isAuthor)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/editBlog', arguments: blog);
                    },
                  ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CommentScreen(
                      blogId: blog.blogId,
                      blogAuthorId: blog.authorId,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.comment),
              label: const Text("View Comments"),
            )
          ],
        ),
      ),
    );
  }
}
