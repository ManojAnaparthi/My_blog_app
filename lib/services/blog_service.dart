import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';

class BlogService {
  final _blogsCollection = FirebaseFirestore.instance.collection('blogs');

  Future<void> createBlog(BlogModel blog) async {
    await _blogsCollection.doc(blog.blogId).set(blog.toMap());
  }

  Future<void> updateBlog(BlogModel blog) async {
    await _blogsCollection.doc(blog.blogId).update(blog.toMap());
  }

  Future<void> deleteBlog(String blogId) async {
    await _blogsCollection.doc(blogId).delete();
  }

  Stream<List<BlogModel>> getAllBlogs() {
    return _blogsCollection.orderBy('timestamp', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => BlogModel.fromMap(doc.data())).toList(),
    );
  }

  Stream<List<BlogModel>> getBlogsByUserIds(List<String> userIds) {
    if (userIds.isEmpty) return Stream.value([]);
    return _blogsCollection
        .where('authorId', whereIn: userIds)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => BlogModel.fromMap(doc.data())).toList());
  }

  Future<void> likeBlog(String blogId, String uid) async {
    await _blogsCollection.doc(blogId).update({
      'likes': FieldValue.arrayUnion([uid]),
    });
  }

  Future<void> unlikeBlog(String blogId, String uid) async {
    await _blogsCollection.doc(blogId).update({
      'likes': FieldValue.arrayRemove([uid]),
    });
  }
}