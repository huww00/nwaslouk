import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpState {
  final String name;
  final String phone;
  final bool isDriver;
  final bool isLoading;
  final String? error;

  const SignUpState({
    this.name = '',
    this.phone = '',
    this.isDriver = false,
    this.isLoading = false,
    this.error,
  });

  SignUpState copyWith({
    String? name,
    String? phone,
    bool? isDriver,
    bool? isLoading,
    String? error,
  }) =>
      SignUpState(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        isDriver: isDriver ?? this.isDriver,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(const SignUpState());

  void updateName(String value) => state = state.copyWith(name: value, error: null);
  void updatePhone(String value) => state = state.copyWith(phone: value, error: null);
  void updateIsDriver(bool value) => state = state.copyWith(isDriver: value, error: null);

  Future<bool> signUp() async {
    if (state.name.isEmpty) {
      state = state.copyWith(error: 'Please enter your full name');
      return false;
    }

    if (state.phone.isEmpty) {
      state = state.copyWith(error: 'Please enter your phone number');
      return false;
    }

    if (!state.phone.startsWith('+216')) {
      state = state.copyWith(error: 'Please enter a valid Tunisian phone number (+216)');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock success - in real implementation, this would call the API
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create account. Please try again.',
      );
      return false;
    }
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);