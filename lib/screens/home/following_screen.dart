import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/user_service.dart';
import '../../../models/user_model.dart';
import '../../widgets/lottie_loading.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final viewedUser = userProvider.viewedUser;
    if (viewedUser == null) {
      return const Scaffold(
        body: Center(child: LottieLoading()),
      );
    }
    final following = viewedUser.following;
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: ListView.builder(
        itemCount: following.length,
        itemBuilder: (context, index) {
          final followingId = following[index];
          return FutureBuilder<AppUser?>(
            future: UserService().getUserById(followingId),
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
