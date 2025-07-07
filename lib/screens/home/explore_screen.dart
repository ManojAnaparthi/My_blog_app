
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/blog_tile.dart';
import '../../../models/blog_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final blogs = blogProvider.blogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: authProvider.user!.uid);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authProvider.logout(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final Blog blog = blogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/blogDetail', arguments: blog);
            },
            child: BlogTile(blog: blog, currentUserId: authProvider.user!.uid),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createBlog');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
