import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> loadUser(String uid) async {
    _user = await _userService.getUser(uid);
    notifyListeners();
  }
}