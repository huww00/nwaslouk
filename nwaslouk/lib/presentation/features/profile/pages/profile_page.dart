import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../../authentication/widgets/soft_ui_text_field.dart';
import '../../authentication/widgets/soft_ui_button.dart';

class ProfilePage extends ConsumerStatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profileProvider.notifier).load());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    if (state.profile != null) {
      _nameCtrl.text = state.profile!.name;
      _phoneCtrl.text = state.profile!.phone;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              ),
            if (state.isLoading && state.profile == null) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            SoftUITextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: _nameCtrl,
              prefixIcon: const Icon(Icons.person, color: Color(0xFFE53E3E)),
            ),
            const SizedBox(height: 16),
            SoftUITextField(
              label: 'Phone',
              hint: '+216########',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone, color: Color(0xFFE53E3E)),
            ),
            const SizedBox(height: 24),
            SoftUIButton(
              text: 'Save',
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final ok = await notifier.update(
                        name: _nameCtrl.text.trim(),
                        phone: _phoneCtrl.text.trim(),
                      );
                      if (!mounted) return;
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated')),
                        );
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}