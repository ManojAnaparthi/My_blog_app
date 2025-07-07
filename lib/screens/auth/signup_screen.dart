
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _profilePicUrlController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: _profilePicUrlController,
              decoration: const InputDecoration(labelText: "Profile Picture URL"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final res = await authProvider.signup(
                  _emailController.text,
                  _passwordController.text,
                  _usernameController.text,
                  _profilePicUrlController.text,
                );
                if (res != null) {
                  setState(() {
                    _error = res;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
