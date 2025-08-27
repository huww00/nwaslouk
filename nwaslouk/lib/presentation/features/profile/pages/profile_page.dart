import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isDriver = false;
  bool _initializedFromProfile = false;

  @override
  void initState() {
    super.initState();
    // Load profile on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _maybeInitializeFromState() {
    final state = ref.read(profileProvider);
    if (!_initializedFromProfile && state.profile != null) {
      _initializedFromProfile = true;
      _nameController.text = state.profile!.name;
      _phoneController.text = state.profile!.phone;
      _locationController.text = '';
      _emailController.text = '';
      _isDriver = state.profile!.isDriver;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    _maybeInitializeFromState();
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.error != null) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(state.error!, style: const TextStyle(color: Colors.red))),
            if (state.isLoading) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email (optional)'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location (optional)'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Driver'),
                const SizedBox(width: 8),
                Switch(
                  value: _isDriver,
                  onChanged: (v) => setState(() => _isDriver = v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        await notifier.update(
                          name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
                          phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
                          location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
                          isDriver: _isDriver,
                          email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
                        );
                        if (!mounted) return;
                        final err = ref.read(profileProvider).error;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err == null ? 'Profile updated' : err)),
                        );
                      },
                child: const Text('Save Changes'),
              ),
            ),
            const Divider(height: 32),
            const Text('Change Password', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Current password'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New password'),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final err = await notifier.changePassword(
                          currentPassword: _currentPasswordController.text,
                          newPassword: _newPasswordController.text,
                        );
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err ?? 'Password changed')),
                        );
                        if (err == null) {
                          _currentPasswordController.clear();
                          _newPasswordController.clear();
                        }
                      },
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}