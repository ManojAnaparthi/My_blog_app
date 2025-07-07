import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/blog_provider.dart';
import '../../widgets/blog_tile.dart';
import '../blog/create_blog_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    blogProvider.listenToBlogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Blogs"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateBlogScreen())),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, child) {
          return ListView.builder(
            itemCount: blogProvider.blogs.length,
            itemBuilder: (ctx, idx) => BlogTile(blog: blogProvider.blogs[idx]),
          );
        },
      ),
    );
  }
}