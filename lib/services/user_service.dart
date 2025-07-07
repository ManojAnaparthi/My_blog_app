import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<UserModel?> getUser(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    if (doc.exists) return UserModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<UserModel>> getUsersByIds(List<String> uids) async {
    if (uids.isEmpty) return [];
    final snap = await _usersCollection.where('uid', whereIn: uids).get();
    return snap.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future<List<UserModel>> getAllUsers() async {
    final snap = await _usersCollection.get();
    return snap.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future<void> followUser(String currentUid, String targetUid) async {
    await _usersCollection.doc(currentUid).update({
      'following': FieldValue.arrayUnion([targetUid])
    });
    await _usersCollection.doc(targetUid).update({
      'followers': FieldValue.arrayUnion([currentUid])
    });
  }

  Future<void> unfollowUser(String currentUid, String targetUid) async {
    await _usersCollection.doc(currentUid).update({
      'following': FieldValue.arrayRemove([targetUid])
    });
    await _usersCollection.doc(targetUid).update({
      'followers': FieldValue.arrayRemove([currentUid])
    });
  }
}