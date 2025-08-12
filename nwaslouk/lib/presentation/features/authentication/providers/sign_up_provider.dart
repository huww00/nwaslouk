import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/sign_up_usecase.dart';

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
  final SignUpUseCase _signUpUseCase = sl<SignUpUseCase>();
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
      state = state.copyWith(error: 'Please enter a valid email address');
      return false;
    }

    if (state.password.isEmpty) {
      state = state.copyWith(error: 'Please enter a password');
      return false;
    }

    if (state.confirmPassword != state.password) {
      state = state.copyWith(error: 'Passwords do not match');
      return false;
    }

    if (state.location.isEmpty) {
      state = state.copyWith(error: 'Please enter your location');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    final result = await _signUpUseCase(SignUpParams(
      email: state.email,
      password: state.password,
      name: state.name,
      phone: state.phone,
      location: state.location,
      isDriver: state.isDriver,
    ));

    return result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      return false;
    }, (r) {
      state = state.copyWith(isLoading: false);
      return true;
    });
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);