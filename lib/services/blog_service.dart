
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';

class BlogService {
  final CollectionReference _blogRef = FirebaseFirestore.instance.collection('blogs');

  Stream<List<Blog>> getAllBlogs() {
    return _blogRef.orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Blog.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> createBlog(Blog blog) async {
    await _blogRef.add(blog.toMap());
  }

  Future<void> toggleLike(String blogId, String uid) async {
    DocumentReference doc = _blogRef.doc(blogId);
    DocumentSnapshot snapshot = await doc.get();
    List<String> likes = List<String>.from((snapshot.data() as Map<String, dynamic>)['likes']);
    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }
    await doc.update({'likes': likes});
  }
}
