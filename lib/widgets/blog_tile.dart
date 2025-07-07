import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blog_model.dart';
import '../providers/blog_provider.dart';
import 'follow_button.dart';

class BlogTile extends StatelessWidget {
  final Blog blog;
  final String currentUserId;

  const BlogTile({super.key, required this.blog, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    return StreamBuilder<Blog>(
      stream: blogProvider.getBlogById(blog.blogId),
      builder: (context, snapshot) {
        final blogData = snapshot.data ?? blog;
        final isLiked = blogData.likes.contains(currentUserId);
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blogData.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("By ${blogData.authorName}",
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                          arguments: blogData.authorId,
                        );
                      },
                      child: const Text('View Author'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(blogData.content),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null),
                      onPressed: () {
                        blogProvider.toggleLike(blogData.blogId, currentUserId);
                      },
                    ),
                    Text('${blogData.likes.length} likes'),
                    const Spacer(),
                    if (blogData.authorId != currentUserId)
                      FollowButton(authorId: blogData.authorId),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
