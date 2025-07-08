import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/blog_provider.dart';
import 'providers/user_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/explore_screen.dart';
import 'screens/blog/create_blog_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/blog/blog_detail_screen.dart';
import 'screens/blog/edit_blog_screen.dart';
import 'models/blog_model.dart';

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
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.indigo,
                centerTitle: true,
                elevation: 4,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 1,
                  minimumSize: const Size(36, 36),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo, width: 1.2),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: const Size(36, 36),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ),
            home: authProvider.isLoggedIn
                ? FutureBuilder(
                    future: Provider.of<UserProvider>(context, listen: false)
                        .loadCurrentUser(authProvider.user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Lottie.asset(
                            'lib/assets/loading.json',
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        );
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
              '/profile': (context) {
                final uid =
                    ModalRoute.of(context)!.settings.arguments as String;
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
