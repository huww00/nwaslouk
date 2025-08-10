import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: notifier.load, child: const Text('Load Profile')),
            const SizedBox(height: 12),
            if (state.error != null) Text(state.error!, style: const TextStyle(color: Colors.red)),
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.profile != null) ...[
              Text('Name: ${state.profile!.name}'),
              Text('Phone: ${state.profile!.phone}'),
              Text('Rating: ${state.profile!.rating.toStringAsFixed(1)}'),
              Text('Driver: ${state.profile!.isDriver ? 'Yes' : 'No'}'),
            ],
          ],
        ),
      ),
    );
  }
}