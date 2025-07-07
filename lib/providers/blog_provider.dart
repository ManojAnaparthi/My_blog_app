import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogProvider extends ChangeNotifier {
  Stream<Blog> getBlogById(String blogId) => _blogService.getBlogById(blogId);
  Future<void> deleteBlog(String blogId) async {
    await _blogService.deleteBlog(blogId);
  }

  final BlogService _blogService = BlogService();
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  BlogProvider() {
    _blogService.getAllBlogs().listen((blogList) {
      _blogs = blogList;
      notifyListeners();
    });
  }

  Future<void> createBlog(Blog blog) async {
    await _blogService.createBlog(blog);
    // Optionally, you can fetch blogs again or rely on the stream
    // _blogs = await _blogService.getAllBlogs().first;
    // notifyListeners();
  }

  Future<void> toggleLike(String blogId, String uid) =>
      _blogService.toggleLike(blogId, uid);
}
