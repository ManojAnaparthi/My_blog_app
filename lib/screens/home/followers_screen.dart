import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';
import '../../widgets/lottie_loading.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final viewedUser = userProvider.viewedUser;
    if (viewedUser == null) {
      return const Scaffold(
        body: Center(child: LottieLoading()),
      );
    }
    final followers = viewedUser.followers;
    return Scaffold(
      appBar: AppBar(title: const Text('Followers')),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final followerId = followers[index];
          return FutureBuilder<AppUser?>(
            future: UserService().getUserById(followerId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const ListTile(title: Text('Loading...'));
              }
              final user = snapshot.data!;
              return ListTile(
                title: Text(user.username),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/profile',
                    (route) => route.isFirst,
                    arguments: user.uid,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
