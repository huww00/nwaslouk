import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/sign_in_provider.dart';
import '../widgets/soft_ui_button.dart';
import '../widgets/soft_ui_text_field.dart';
import 'sign_up_page.dart';
import '../../search_trips/pages/search_trips_page.dart';

class SignInPage extends ConsumerWidget {
  static const String routeName = '/';
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    final notifier = ref.read(signInProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              
              // Logo and Title
              Container(
                width: 120,
                height: 120,
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
                  Icons.directions_car,
                  size: 60,
                  color: Color(0xFFE53E3E),
                ),
              ),
              
              const SizedBox(height: 32),
              
              const Text(
                'نوصلوك',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE53E3E),
                ),
              ),
              
              const SizedBox(height: 8),
              
              const Text(
                'Your Louage Travel Companion',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF718096),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Sign In Form
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
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    SoftUITextField(
                      label: 'Email or Phone Number',
                      hint: 'you@example.com or +216 XX XXX XXX',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: notifier.updateIdentifier,
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    SoftUITextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      obscureText: true,
                      onChanged: notifier.updatePassword,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFFE53E3E),
                      ),
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
                      text: 'Sign In',
                      isLoading: state.isLoading,
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final success = await notifier.signIn();
                              if (context.mounted && success) {
                                Navigator.of(context).pushReplacementNamed(
                                  SearchTripsPage.routeName,
                                );
                              }
                            },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            SignUpPage.routeName,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFFE53E3E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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