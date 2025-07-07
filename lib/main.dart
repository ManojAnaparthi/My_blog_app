
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/blog_provider.dart';
import 'providers/user_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/explore_screen.dart';
import 'screens/blog/create_blog_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/home/following_screen.dart';
import 'screens/blog/blog_detail_screen.dart';
import 'screens/blog/edit_blog_screen.dart';
import 'models/blog_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: authProvider.isLoggedIn
                ? FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .loadCurrentUser(authProvider.user!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const ExploreScreen();
              },
            )
                : const LoginScreen(),
            routes: {
              '/login': (_) => const LoginScreen(),
              '/signup': (_) => const SignupScreen(),
              '/explore': (_) => const ExploreScreen(),
              '/createBlog': (_) => const CreateBlogScreen(),
              '/following': (_) => const FollowingScreen(),
              '/profile': (context) {
                final uid = ModalRoute.of(context)!.settings.arguments as String;
                return ProfileScreen(uid: uid);
              },
              '/blogDetail': (context) {
                final blog = ModalRoute.of(context)!.settings.arguments as Blog;
                return BlogDetailScreen(blog: blog);
              },
              '/editBlog': (context) {
                final blog = ModalRoute.of(context)!.settings.arguments as Blog;
                return EditBlogScreen(blog: blog);
              },
            },
          );
        },
      ),
    );
  }
}
