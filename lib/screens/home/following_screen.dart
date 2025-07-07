import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/blog_provider.dart';
import '../../widgets/blog_tile.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final following = authProvider.userModel?.following ?? [];
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Following")),
      body: StreamBuilder(
        stream: blogProvider.getBlogsByUserIds(following),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final blogs = snapshot.data!;
          if (blogs.isEmpty) return const Center(child: Text("No blogs from followed users"));
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (ctx, idx) => BlogTile(blog: blogs[idx]),
          );
        },
      ),
    );
  }
}