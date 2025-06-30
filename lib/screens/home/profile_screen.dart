
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: StreamBuilder<AppUser>(
        stream: userProvider.getUserStream(authProvider.user!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: user.profilePicUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.person, size: 100),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(user.username, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 10),
                Text(user.email),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Followers: ${user.followers.length}"),
                    const SizedBox(width: 20),
                    Text("Following: ${user.following.length}"),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
