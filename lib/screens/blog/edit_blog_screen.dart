
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/blog_model.dart';
import '../../../providers/blog_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditBlogScreen extends StatefulWidget {
  final Blog blog;
  const EditBlogScreen({super.key, required this.blog});

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog.title);
    _contentController = TextEditingController(text: widget.blog.content);
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Blog")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('blogs')
                    .doc(widget.blog.blogId)
                    .update({
                  'title': _titleController.text,
                  'content': _contentController.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Update Blog"),
            )
          ],
        ),
      ),
    );
  }
}
