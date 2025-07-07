import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogProvider with ChangeNotifier {
  final BlogService _blogService = BlogService();
  List<BlogModel> _blogs = [];
  List<BlogModel> get blogs => _blogs;

  void listenToBlogs() {
    _blogService.getAllBlogs().listen((blogList) {
      _blogs = blogList;
      notifyListeners();
    });
  }

  Stream<List<BlogModel>> getBlogsByUserIds(List<String> uids) =>
      _blogService.getBlogsByUserIds(uids);

  Future<void> createBlog(BlogModel blog) => _blogService.createBlog(blog);
  Future<void> updateBlog(BlogModel blog) => _blogService.updateBlog(blog);
  Future<void> deleteBlog(String blogId) => _blogService.deleteBlog(blogId);

  Future<void> likeBlog(String blogId, String uid) =>
      _blogService.likeBlog(blogId, uid);
  Future<void> unlikeBlog(String blogId, String uid) =>
      _blogService.unlikeBlog(blogId, uid);
}