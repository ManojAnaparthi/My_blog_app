
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/blog_model.dart';
import '../../providers/blog_provider.dart';
import '../../providers/auth_provider.dart';
import '../blog/blog_detail_screen.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    blogProvider.loadFollowingBlogs(authProvider.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<BlogProvider>(context).blogs;

    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: blogs.isEmpty
          ? const Center(child: Text('No blogs from followed users'))
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return ListTile(
                  title: Text(blog.title),
                  subtitle: Text('by ${blog.authorName}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
