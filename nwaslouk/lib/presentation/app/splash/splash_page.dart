import 'package:flutter/material.dart';
import '../../features/authentication/pages/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Nwaslouk', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}