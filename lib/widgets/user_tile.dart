
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class UserTile extends StatelessWidget {
  final AppUser user;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const UserTile({
    super.key,
    required this.user,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profilePicUrl),
      ),
      title: Text(user.username),
      subtitle: Text(user.email),
      trailing: TextButton(
        onPressed: onFollowToggle,
        child: Text(isFollowing ? 'Unfollow' : 'Follow'),
      ),
    );
  }
}
