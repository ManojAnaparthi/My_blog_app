import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/blog_model.dart';
import '../../providers/blog_provider.dart';

class EditBlogScreen extends StatefulWidget {
  final BlogModel blog;
  const EditBlogScreen({required this.blog, super.key});
  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.blog.title);
    contentController = TextEditingController(text: widget.blog.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Blog')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: titleController, decoration: const InputDecoration(labelText: "Title"), validator: (v) => v == null || v.isEmpty ? "Enter title" : null),
              TextFormField(controller: contentController, decoration: const InputDecoration(labelText: "Content"), minLines: 5, maxLines: 10, validator: (v) => v == null || v.isEmpty ? "Enter content" : null),
              const SizedBox(height: 20),
              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    final updatedBlog = BlogModel(
                      blogId: widget.blog.blogId,
                      authorId: widget.blog.authorId,
                      authorName: widget.blog.authorName,
                      authorPic: widget.blog.authorPic,
                      title: titleController.text,
                      content: contentController.text,
                      timestamp: DateTime.now(),
                      likes: widget.blog.likes,
                    );
                    await Provider.of<BlogProvider>(context, listen: false).updateBlog(updatedBlog);
                    setState(() => loading = false);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}