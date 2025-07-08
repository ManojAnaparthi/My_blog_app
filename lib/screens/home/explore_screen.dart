import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/blog_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/blog_tile.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final blogs = blogProvider.blogs;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 36,
          child: Image.asset(
            'lib/images/175191701450420a90bcw.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile',
                    arguments: authProvider.user!.uid);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.indigo),
              title: const Text('Logout'),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Logout',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  authProvider.logout();
                }
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/blogDetail', arguments: blog);
            },
            child: BlogTile(blog: blog, currentUserId: authProvider.user!.uid),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createBlog');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
