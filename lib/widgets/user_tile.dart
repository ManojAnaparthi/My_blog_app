
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final AppUser user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.profilePicUrl)),
      title: Text(user.username),
      subtitle: Text(user.email),
      onTap: onTap,
    );
  }
}
