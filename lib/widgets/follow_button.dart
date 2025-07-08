import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class FollowButton extends StatelessWidget {
  final String authorId;
  const FollowButton({required this.authorId, super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;
    if (currentUser == null) return const SizedBox();
    final isFollowing = currentUser.following.contains(authorId);
    return ElevatedButton(
      onPressed: () async {
        await userProvider.toggleFollow(currentUser.uid, authorId);
        await userProvider.loadCurrentUser(currentUser.uid);
      },
      child: Text(isFollowing ? 'Unfollow' : 'Follow'),
    );
  }
}
