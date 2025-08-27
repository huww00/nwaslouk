import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/logout_usecase.dart';
import 'sign_in_page.dart';
import '../../profile/pages/profile_page.dart';

class AuthSuccessPage extends ConsumerWidget {
  static const String routeName = '/auth-success';
  const AuthSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () => Navigator.of(context).pushNamed(ProfilePage.routeName),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Successful authentication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final result = await sl<LogoutUseCase>()();
                result.fold((l) {}, (r) {});
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(SignInPage.routeName, (_) => false);
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}