import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/blog_tile.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final blogProvider = Provider.of<BlogProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final viewedUser = userProvider.viewedUser;
    final currentUser = userProvider.currentUser;

    if (viewedUser == null || viewedUser.uid != uid) {
      userProvider.fetchUser(uid);
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userBlogs = blogProvider.blogs
        .where((blog) => blog.authorId == viewedUser.uid)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(viewedUser.username)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(viewedUser.profilePicUrl),
              radius: 40,
            ),
            const SizedBox(height: 12),
            Text(viewedUser.username,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(viewedUser.email),
            const SizedBox(height: 8),
            Text("Followers: ${viewedUser.followers.length}"),
            Text("Following: ${viewedUser.following.length}"),
            const SizedBox(height: 12),
            if (viewedUser.uid != currentUser?.uid)
              ElevatedButton(
                onPressed: () async {
                  await userProvider.toggleFollow(currentUser!.uid, viewedUser.uid);
                  await userProvider.loadCurrentUser(currentUser.uid);
                },
                child: Text(
                  currentUser!.following.contains(viewedUser.uid) ? 'Unfollow' : 'Follow',
                ),
              ),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Blogs:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: userBlogs.length,
                itemBuilder: (context, index) {
                  return BlogTile(
                    blog: userBlogs[index],
                    currentUserId: authProvider.user!.uid,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
