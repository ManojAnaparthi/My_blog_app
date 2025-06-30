
import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogProvider extends ChangeNotifier {
  final BlogService _blogService = BlogService();
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  BlogProvider() {
    _blogService.getAllBlogs().listen((blogList) {
      _blogs = blogList;
      notifyListeners();
    });
  }

  Future<void> createBlog(Blog blog) => _blogService.createBlog(blog);

  Future<void> toggleLike(String blogId, String uid) => _blogService.toggleLike(blogId, uid);
}

