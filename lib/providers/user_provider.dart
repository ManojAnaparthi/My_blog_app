import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  AppUser? _currentUser;
  AppUser? _viewedUser;

  AppUser? get currentUser => _currentUser;
  AppUser? get viewedUser => _viewedUser;

  Future<void> loadCurrentUser(String uid) async {
    _currentUser = await _userService.getUserById(uid);
    notifyListeners();
  }

  Future<void> fetchUser(String uid) async {
    _viewedUser = await _userService.getUserById(uid);
    notifyListeners();
  }

  Future<void> toggleFollow(String currentUserId, String targetUserId) async {
    await _userService.toggleFollow(currentUserId, targetUserId);
    await fetchUser(targetUserId);
  }
}
