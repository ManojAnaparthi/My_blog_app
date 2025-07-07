import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final profilePicController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextFormField(controller: usernameController, decoration: const InputDecoration(labelText: "Username")),
              TextFormField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextFormField(controller: passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
              TextFormField(controller: profilePicController, decoration: const InputDecoration(labelText: "Profile Picture URL")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await Provider.of<AuthProvider>(context, listen: false).signup(
                        emailController.text.trim(),
                        passwordController.text,
                        usernameController.text,
                        profilePicController.text.trim().isEmpty
                            ? defaultProfilePic
                            : profilePicController.text,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}