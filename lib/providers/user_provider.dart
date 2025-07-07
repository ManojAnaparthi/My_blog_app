import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  AppUser? _currentUser;
  AppUser? _viewedUser;
  bool _isLoadingViewedUser = false;

  AppUser? get currentUser => _currentUser;
  AppUser? get viewedUser => _viewedUser;
  bool get isLoadingViewedUser => _isLoadingViewedUser;

  Future<void> loadCurrentUser(String uid) async {
    _currentUser = await _userService.getUserById(uid);
    notifyListeners();
  }

  Future<void> fetchUser(String uid) async {
    if (_isLoadingViewedUser) return; // Prevent multiple simultaneous requests
    
    _isLoadingViewedUser = true;
    notifyListeners();
    
    try {
      _viewedUser = await _userService.getUserById(uid);
    } finally {
      _isLoadingViewedUser = false;
      notifyListeners();
    }
  }

  Future<void> toggleFollow(String currentUserId, String targetUserId) async {
    await _userService.toggleFollow(currentUserId, targetUserId);
    await fetchUser(targetUserId);
  }
}
