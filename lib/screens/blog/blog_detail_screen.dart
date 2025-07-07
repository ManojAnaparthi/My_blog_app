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
    return StreamBuilder<Blog>(
      stream: blogProvider.getBlogById(blog.blogId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final blogData = snapshot.data!;
        final isAuthor = auth.user!.uid == blogData.authorId;
        final isLiked = blogData.likes.contains(auth.user!.uid);
        return Scaffold(
          appBar: AppBar(title: Text(blogData.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blogData.content),
                const SizedBox(height: 16),
                Text("By ${blogData.authorName}",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null),
                      onPressed: () {
                        blogProvider.toggleLike(
                            blogData.blogId, auth.user!.uid);
                      },
                    ),
                    Text('${blogData.likes.length} likes'),
                    const Spacer(),
                    if (isAuthor)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/editBlog',
                              arguments: blogData);
                        },
                      ),
                    if (isAuthor)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Blog'),
                              content: const Text(
                                  'Are you sure you want to delete this blog?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Delete',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await blogProvider.deleteBlog(blogData.blogId);
                            if (context.mounted) Navigator.of(context).pop();
                          }
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
                          blogId: blogData.blogId,
                          blogAuthorId: blogData.authorId,
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
      },
    );
  }
}
