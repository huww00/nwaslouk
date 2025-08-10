import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/sign-up';
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: const Center(child: Text('Sign Up – coming soon')),
    );
  }
}