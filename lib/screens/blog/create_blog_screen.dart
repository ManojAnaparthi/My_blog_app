import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../providers/blog_provider.dart';
import '../../models/blog_model.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});
  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Blog')),
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
                    final blog = BlogModel(
                      blogId: const Uuid().v4(),
                      authorId: authProvider.user!.uid,
                      authorName: authProvider.userModel!.username,
                      authorPic: authProvider.userModel!.profilePicUrl,
                      title: titleController.text,
                      content: contentController.text,
                      timestamp: DateTime.now(),
                      likes: [],
                    );
                    await Provider.of<BlogProvider>(context, listen: false).createBlog(blog);
                    setState(() => loading = false);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Post"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}