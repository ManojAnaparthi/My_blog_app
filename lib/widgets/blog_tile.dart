import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/blog_model.dart';
import '../screens/blog/blog_detail_screen.dart';

class BlogTile extends StatelessWidget {
  final BlogModel blog;
  const BlogTile({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(blog.authorPic),
        ),
        title: Text(blog.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(blog.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 18, color: Colors.red),
            Text('${blog.likes.length}'),
          ],
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BlogDetailScreen(blog: blog))),
      ),
    );
  }
}