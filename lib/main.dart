
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/blog_provider.dart';
import 'providers/user_provider.dart';
import 'providers/comment_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/explore_screen.dart';
import 'screens/home/following_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/blog/create_blog_screen.dart';
import 'screens/blog/edit_blog_screen.dart';
import 'firebase_options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/explore': (context) => const ExploreScreen(),
          '/following': (context) => const FollowingScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/create': (context) => const CreateBlogScreen(),
          '/edit': (context) => const EditBlogScreen(blog: null),
        },
      ),
    );
  }
}
