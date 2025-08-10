import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/sign_in_provider.dart';
import '../../../features/search_trips/pages/search_trips_page.dart';

class SignInPage extends ConsumerWidget {
  static const String routeName = '/';
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    final notifier = ref.read(signInProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Nwaslouk Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Phone (+216...)'),
              onChanged: notifier.updatePhone,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'OTP'),
              onChanged: notifier.updateOtp,
            ),
            const SizedBox(height: 16),
            if (state.error != null)
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final success = await notifier.signIn();
                      if (context.mounted && success) {
                        Navigator.of(context).pushReplacementNamed(SearchTripsPage.routeName);
                      }
                    },
              child: state.isLoading ? const CircularProgressIndicator() : const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}