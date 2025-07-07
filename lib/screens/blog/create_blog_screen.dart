import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/blog_model.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user!;

    return Scaffold(
      appBar: AppBar(title: const Text("Create Blog")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Fetch username from Firestore
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get();
                final username = userDoc.data()?['username'] ?? 'Unknown';
                final newBlog = Blog(
                  blogId: '', // Will be set in BlogService
                  authorId: user.uid,
                  authorName: username,
                  title: _titleController.text,
                  content: _contentController.text,
                  timestamp: DateTime.now(),
                  likes: [],
                );
                await blogProvider.createBlog(newBlog);
                if (mounted) Navigator.pop(context);
              },
              child: const Text("Post Blog"),
            )
          ],
        ),
      ),
    );
  }
}
