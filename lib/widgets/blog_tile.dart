
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blog_model.dart';
import '../providers/blog_provider.dart';

class BlogTile extends StatelessWidget {
  final Blog blog;
  final String currentUserId;

  const BlogTile({super.key, required this.blog, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    final isLiked = blog.likes.contains(currentUserId);

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blog.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("By ${blog.authorName}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(blog.content),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : null),
                  onPressed: () {
                    blogProvider.toggleLike(blog.blogId, currentUserId);
                  },
                ),
                Text('${blog.likes.length} likes'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
