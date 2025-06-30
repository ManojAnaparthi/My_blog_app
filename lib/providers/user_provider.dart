
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  AppUser? _user;

  AppUser? get user => _user;

  Future<void> fetchUser(String uid) async {
    _user = await _userService.getUserById(uid);
    notifyListeners();
  }

  Stream<AppUser> streamUser(String uid) {
    return _userService.streamUser(uid);
  }

  Future<void> follow(String currentUid, String targetUid) async {
    await _userService.followUser(currentUid, targetUid);
  }

  Future<void> unfollow(String currentUid, String targetUid) async {
    await _userService.unfollowUser(currentUid, targetUid);
  }
}
