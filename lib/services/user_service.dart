
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(AppUser user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<AppUser?> getUserById(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> followUser(String currentUid, String targetUid) async {
    await _firestore.collection('users').doc(currentUid).update({
      'following': FieldValue.arrayUnion([targetUid])
    });
    await _firestore.collection('users').doc(targetUid).update({
      'followers': FieldValue.arrayUnion([currentUid])
    });
  }

  Future<void> unfollowUser(String currentUid, String targetUid) async {
    await _firestore.collection('users').doc(currentUid).update({
      'following': FieldValue.arrayRemove([targetUid])
    });
    await _firestore.collection('users').doc(targetUid).update({
      'followers': FieldValue.arrayRemove([currentUid])
    });
  }

  Stream<List<AppUser>> getAllUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data())).toList();
    });
  }

  Stream<AppUser> streamUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
        (snapshot) => AppUser.fromMap(snapshot.data()!));
  }
}
