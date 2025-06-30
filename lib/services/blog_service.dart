
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createBlog(Blog blog) async {
    await _firestore.collection('blogs').doc(blog.blogId).set(blog.toMap());
  }

  Future<void> updateBlog(Blog blog) async {
    await _firestore.collection('blogs').doc(blog.blogId).update(blog.toMap());
  }

  Future<void> deleteBlog(String blogId) async {
    await _firestore.collection('blogs').doc(blogId).delete();
  }

  Future<List<Blog>> getAllBlogs() async {
    final snapshot = await _firestore.collection('blogs').orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => Blog.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<Blog>> getBlogsByUser(String uid) async {
    final snapshot = await _firestore.collection('blogs')
        .where('authorId', isEqualTo: uid)
        .orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => Blog.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<Blog>> getBlogsByFollowedUsers(List<String> following) async {
    if (following.isEmpty) return [];
    final snapshot = await _firestore.collection('blogs')
        .where('authorId', whereIn: following)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => Blog.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> toggleLike(String blogId, String uid, bool isLiked) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'likes': isLiked
          ? FieldValue.arrayRemove([uid])
          : FieldValue.arrayUnion([uid])
    });
  }
}
