
import 'package:flutter/material.dart';
import '../../models/blog_model.dart';

class BlogTile extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const BlogTile({super.key, required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(blog.title),
        subtitle: Text('by ${blog.authorName}'),
        onTap: onTap,
      ),
    );
  }
}
