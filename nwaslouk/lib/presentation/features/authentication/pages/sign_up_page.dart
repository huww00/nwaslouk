import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nwaslouk/presentation/features/authentication/pages/sign_in_page.dart';
import '../providers/sign_up_provider.dart';
import '../widgets/soft_ui_button.dart';
import '../widgets/soft_ui_text_field.dart';
import '../widgets/celebration_dialog.dart';
import 'success_page.dart';
class SignUpPage extends ConsumerWidget {
  static const String routeName = '/sign-up';
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              
              // Back Button
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFC),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          const BoxShadow(
                            color: Color(0xFFE2E8F0),
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            blurRadius: 10,
                            offset: Offset(-5, -5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Logo and Title
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  shape: BoxShape.circle,
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFE2E8F0),
                      blurRadius: 20,
                      offset: Offset(10, 10),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 20,
                      offset: Offset(-10, -10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_add,
                  size: 50,
                  color: Color(0xFFE53E3E),
                ),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              
              const SizedBox(height: 8),
              
              const Text(
                'Join Nwaslouk community',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF718096),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Sign Up Form
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFE2E8F0),
                      blurRadius: 20,
                      offset: Offset(10, 10),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 20,
                      offset: Offset(-10, -10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SoftUITextField(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      onChanged: notifier.updateName,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.nameError != null)
                      const SizedBox(height: 8),
                    if (state.nameError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.nameError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),
                    
                    const SizedBox(height: 24),
                    
                    SoftUITextField(
                      label: 'Phone Number',
                      hint: '+216 XX XXX XXX',
                      keyboardType: TextInputType.phone,
                      onChanged: notifier.updatePhone,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.phoneError != null)
                      const SizedBox(height: 8),
                    if (state.phoneError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.phoneError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),
                    if (state.phoneError == null && state.phone.isNotEmpty && state.phoneExists != null)
                      const SizedBox(height: 8),
                    if (state.phoneError == null && state.phone.isNotEmpty && state.phoneExists != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.phoneExists == true ? 'Phone already in use' : 'Phone available',
                          style: TextStyle(color: state.phoneExists == true ? const Color(0xFFE53E3E) : const Color(0xFF38A169), fontSize: 12),
                        ),
                      ),

                    const SizedBox(height: 24),

                    SoftUITextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: notifier.updateEmail,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.emailError != null)
                      const SizedBox(height: 8),
                    if (state.emailError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.emailError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),
                    if (state.emailError == null && state.email.isNotEmpty && state.emailExists != null)
                      const SizedBox(height: 8),
                    if (state.emailError == null && state.email.isNotEmpty && state.emailExists != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.emailExists == true ? 'Email already in use' : 'Email available',
                          style: TextStyle(color: state.emailExists == true ? const Color(0xFFE53E3E) : const Color(0xFF38A169), fontSize: 12),
                        ),
                      ),

                    const SizedBox(height: 24),

                    SoftUITextField(
                      label: 'Password',
                      hint: 'Create a password',
                      obscureText: true,
                      onChanged: notifier.updatePassword,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.passwordError != null)
                      const SizedBox(height: 8),
                    if (state.passwordError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.passwordError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),

                    const SizedBox(height: 24),

                    SoftUITextField(
                      label: 'Confirm Password',
                      hint: 'Re-enter your password',
                      obscureText: true,
                      onChanged: notifier.updateConfirmPassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.confirmPasswordError != null)
                      const SizedBox(height: 8),
                    if (state.confirmPasswordError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.confirmPasswordError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),

                    const SizedBox(height: 24),

                    SoftUITextField(
                      label: 'Location',
                      hint: 'Your city or area',
                      onChanged: notifier.updateLocation,
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    if (state.locationError != null)
                      const SizedBox(height: 8),
                    if (state.locationError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.locationError!, style: const TextStyle(color: Color(0xFFE53E3E), fontSize: 12)),
                      ),
                    
                    const SizedBox(height: 24),
                    
                    // User Type Selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'I am a',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4A5568),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => notifier.updateIsDriver(false),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7FAFC),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: !state.isDriver
                                          ? const Color(0xFFE53E3E)
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    boxShadow: !state.isDriver
                                        ? [
                                            const BoxShadow(
                                              color: Color(0xFFE53E3E),
                                              blurRadius: 0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : [
                                            const BoxShadow(
                                              color: Color(0xFFE2E8F0),
                                              blurRadius: 10,
                                              offset: Offset(5, 5),
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10,
                                              offset: Offset(-5, -5),
                                            ),
                                          ],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: !state.isDriver
                                            ? const Color(0xFFE53E3E)
                                            : const Color(0xFF718096),
                                        size: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Passenger',
                                        style: TextStyle(
                                          color: !state.isDriver
                                              ? const Color(0xFFE53E3E)
                                              : const Color(0xFF718096),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => notifier.updateIsDriver(true),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7FAFC),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: state.isDriver
                                          ? const Color(0xFFE53E3E)
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    boxShadow: state.isDriver
                                        ? [
                                            const BoxShadow(
                                              color: Color(0xFFE53E3E),
                                              blurRadius: 0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : [
                                            const BoxShadow(
                                              color: Color(0xFFE2E8F0),
                                              blurRadius: 10,
                                              offset: Offset(5, 5),
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10,
                                              offset: Offset(-5, -5),
                                            ),
                                          ],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.drive_eta,
                                        color: state.isDriver
                                            ? const Color(0xFFE53E3E)
                                            : const Color(0xFF718096),
                                        size: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Driver',
                                        style: TextStyle(
                                          color: state.isDriver
                                              ? const Color(0xFFE53E3E)
                                              : const Color(0xFF718096),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    if (state.error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFED7D7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Color(0xFFE53E3E),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.error!,
                                style: const TextStyle(
                                  color: Color(0xFFE53E3E),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    SoftUIButton(
                      text: 'Create Account',
                      isLoading: state.isLoading,
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final success = await notifier.signUp();
                              if (context.mounted && success) {
                                await showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => const CelebrationDialog(
                                    title: 'Account created!',
                                    message: 'Your account has been created successfully.',
                                  ),
                                );
                                if (context.mounted) {
                                  Navigator.of(context).pushReplacementNamed(
                                    AuthSuccessPage.routeName,
                                  );
                                }
                              }
                            },
                    ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacementNamed(SignInPage.routeName),
                      child: const Text(
                        'Already have an account? Sign in',
                        style: TextStyle(color: Color(0xFF718096), fontSize: 14, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
