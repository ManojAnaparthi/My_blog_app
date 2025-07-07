import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onFollow;
  final VoidCallback? onUnfollow;
  final bool isFollowing;

  const UserTile({required this.user, this.onFollow, this.onUnfollow, this.isFollowing = false, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.profilePicUrl)),
      title: Text(user.username),
      subtitle: Text(user.email),
      trailing: isFollowing
          ? TextButton(onPressed: onUnfollow, child: const Text('Unfollow'))
          : TextButton(onPressed: onFollow, child: const Text('Follow')),
    );
  }
}