import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  UserModel? _userModel;
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  User? get user => _user;
  UserModel? get userModel => _userModel;

  AuthProvider() {
    _authService.userStream.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      _userModel = await _userService.getUser(user.uid);
    } else {
      _userModel = null;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await _authService.signIn(email, password);
  }

  Future<void> signup(String email, String password, String username, String profilePicUrl) async {
    await _authService.signUp(email, password, username, profilePicUrl);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}