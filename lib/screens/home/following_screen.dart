import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/blog_tile.dart';
import '../../../models/blog_model.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final currentUser = authProvider.user!;
    final followedIds = userProvider.currentUser?.following ?? [];

    final followedBlogs = blogProvider.blogs
        .where((blog) => followedIds.contains(blog.authorId))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Following")),
      body: ListView.builder(
        itemCount: followedBlogs.length,
        itemBuilder: (context, index) {
          final Blog blog = followedBlogs[index];
          return BlogTile(blog: blog, currentUserId: currentUser.uid);
        },
      ),
    );
  }
}
