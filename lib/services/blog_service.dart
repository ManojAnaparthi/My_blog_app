import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';

class BlogService {
  Stream<Blog> getBlogById(String blogId) {
    return _blogRef
        .doc(blogId)
        .snapshots()
        .map((doc) => Blog.fromMap(doc.data() as Map<String, dynamic>, doc.id));
  }

  Future<void> deleteBlog(String blogId) async {
    await _blogRef.doc(blogId).delete();
  }

  final CollectionReference _blogRef =
      FirebaseFirestore.instance.collection('blogs');

  Stream<List<Blog>> getAllBlogs() {
    return _blogRef.orderBy('timestamp', descending: true).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                Blog.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> createBlog(Blog blog) async {
    DocumentReference docRef = _blogRef.doc();
    final blogWithId = Blog(
      blogId: docRef.id,
      authorId: blog.authorId,
      authorName: blog.authorName,
      title: blog.title,
      content: blog.content,
      timestamp: blog.timestamp,
      likes: blog.likes,
    );
    await docRef.set(blogWithId.toMap());
  }

  Future<void> toggleLike(String blogId, String uid) async {
    DocumentReference doc = _blogRef.doc(blogId);
    DocumentSnapshot snapshot = await doc.get();
    List<String> likes =
        List<String>.from((snapshot.data() as Map<String, dynamic>)['likes']);
    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }
    await doc.update({'likes': likes});
  }
}
