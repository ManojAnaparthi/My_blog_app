import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/blog_tile.dart';
import '../../providers/blog_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    final user = authProvider.userModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await authProvider.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(user.profilePicUrl),
          ),
          const SizedBox(height: 8),
          Text(user.username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(user.email),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Text('${user.followers.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('Followers'),
              ]),
              const SizedBox(width: 24),
              Column(children: [
                Text('${user.following.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('Following'),
              ]),
            ],
          ),
          const Divider(),
          const Text("My Blogs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: StreamBuilder(
              stream: blogProvider.getBlogsByUserIds([user.uid]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final blogs = snapshot.data!;
                if (blogs.isEmpty) return const Center(child: Text("No blogs yet"));
                return ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (ctx, idx) => BlogTile(blog: blogs[idx]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}