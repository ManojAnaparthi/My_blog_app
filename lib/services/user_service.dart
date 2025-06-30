
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final CollectionReference _userRef = FirebaseFirestore.instance.collection('users');

  Future<AppUser> getUserById(String uid) async {
    DocumentSnapshot snapshot = await _userRef.doc(uid).get();
    return AppUser.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> toggleFollow(String currentUserId, String targetUserId) async {
    DocumentReference currentRef = _userRef.doc(currentUserId);
    DocumentReference targetRef = _userRef.doc(targetUserId);

    DocumentSnapshot currentSnap = await currentRef.get();
    DocumentSnapshot targetSnap = await targetRef.get();

    List<String> currentFollowing = List<String>.from(currentSnap['following']);
    List<String> targetFollowers = List<String>.from(targetSnap['followers']);

    if (currentFollowing.contains(targetUserId)) {
      currentFollowing.remove(targetUserId);
      targetFollowers.remove(currentUserId);
    } else {
      currentFollowing.add(targetUserId);
      targetFollowers.add(currentUserId);
    }

    await currentRef.update({'following': currentFollowing});
    await targetRef.update({'followers': targetFollowers});
  }
}
