
import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogProvider with ChangeNotifier {
  final BlogService _blogService = BlogService();
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  Future<void> loadAllBlogs() async {
    _blogs = await _blogService.getAllBlogs();
    notifyListeners();
  }

  Future<void> loadUserBlogs(String uid) async {
    _blogs = await _blogService.getBlogsByUser(uid);
    notifyListeners();
  }

  Future<void> loadFollowingBlogs(List<String> following) async {
    _blogs = await _blogService.getBlogsByFollowedUsers(following);
    notifyListeners();
  }

  Future<void> addBlog(Blog blog) async {
    await _blogService.createBlog(blog);
    _blogs.insert(0, blog);
    notifyListeners();
  }

  Future<void> updateBlog(Blog updatedBlog) async {
    await _blogService.updateBlog(updatedBlog);
    final index = _blogs.indexWhere((b) => b.blogId == updatedBlog.blogId);
    if (index != -1) {
      _blogs[index] = updatedBlog;
      notifyListeners();
    }
  }

  Future<void> deleteBlog(String blogId) async {
    await _blogService.deleteBlog(blogId);
    _blogs.removeWhere((b) => b.blogId == blogId);
    notifyListeners();
  }

  Future<void> toggleLike(String blogId, String uid, bool isLiked) async {
    await _blogService.toggleLike(blogId, uid, isLiked);
    final index = _blogs.indexWhere((b) => b.blogId == blogId);
    if (index != -1) {
      if (isLiked) {
        _blogs[index].likes.remove(uid);
      } else {
        _blogs[index].likes.add(uid);
      }
      notifyListeners();
    }
  }
}
