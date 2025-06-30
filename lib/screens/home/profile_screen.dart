
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/blog_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUser(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final blogProvider = Provider.of<BlogProvider>(context);

    final currentUser = authProvider.user!;
    final viewedUser = userProvider.viewedUser;

    final userBlogs = blogProvider.blogs.where((b) => b.authorId == widget.uid).toList();

    if (viewedUser == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final isFollowing = viewedUser.followers.contains(currentUser.uid);

    return Scaffold(
      appBar: AppBar(title: Text(viewedUser.username)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(viewedUser.profilePicUrl),
              radius: 40,
            ),
            const SizedBox(height: 12),
            Text(viewedUser.email),
            const SizedBox(height: 8),
            Text("Followers: ${viewedUser.followers.length} • Following: ${viewedUser.following.length}"),
            const SizedBox(height: 12),
            if (currentUser.uid != viewedUser.uid)
              ElevatedButton(
                onPressed: () => userProvider.toggleFollow(currentUser.uid, viewedUser.uid),
                child: Text(isFollowing ? 'Unfollow' : 'Follow'),
              ),
            const Divider(height: 32),
            const Text('Blogs', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: userBlogs.length,
                itemBuilder: (context, index) {
                  final blog = userBlogs[index];
                  return ListTile(
                    title: Text(blog.title),
                    subtitle: Text(blog.content),
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
