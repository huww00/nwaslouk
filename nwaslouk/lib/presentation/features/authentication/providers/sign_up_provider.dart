import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpState {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String location;
  final bool isDriver;
  final bool isLoading;
  final String? error;

  const SignUpState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.location = '',
    this.isDriver = false,
    this.isLoading = false,
    this.error,
  });

  SignUpState copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
    String? confirmPassword,
    String? location,
    bool? isDriver,
    bool? isLoading,
    String? error,
  }) =>
      SignUpState(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        location: location ?? this.location,
        isDriver: isDriver ?? this.isDriver,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(const SignUpState());

  void updateName(String value) => state = state.copyWith(name: value, error: null);
  void updatePhone(String value) => state = state.copyWith(phone: value, error: null);
  void updateEmail(String value) => state = state.copyWith(email: value, error: null);
  void updatePassword(String value) => state = state.copyWith(password: value, error: null);
  void updateConfirmPassword(String value) => state = state.copyWith(confirmPassword: value, error: null);
  void updateLocation(String value) => state = state.copyWith(location: value, error: null);
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

    if (state.email.isEmpty || !state.email.contains('@')) {
      state = state.copyWith(error: 'Please enter a valid email');
      return false;
    }

    if (state.password.length < 6) {
      state = state.copyWith(error: 'Password must be at least 6 characters');
      return false;
    }

    if (state.password != state.confirmPassword) {
      state = state.copyWith(error: 'Passwords do not match');
      return false;
    }

    if (state.location.isEmpty) {
      state = state.copyWith(error: 'Please enter your location');
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