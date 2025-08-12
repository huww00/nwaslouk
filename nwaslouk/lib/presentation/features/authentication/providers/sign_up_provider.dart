import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/sign_up_usecase.dart';
import '../../../../core/validation/input_validators.dart';
import '../../../../data/datasources/remote/auth_api.dart';

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
  final String? nameError;
  final String? phoneError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? locationError;
  final bool? emailExists;
  final bool? phoneExists;

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
    this.nameError,
    this.phoneError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.locationError,
    this.emailExists,
    this.phoneExists,
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
    String? nameError,
    String? phoneError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? locationError,
    bool? emailExists,
    bool? phoneExists,
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
        nameError: nameError,
        phoneError: phoneError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        locationError: locationError,
        emailExists: emailExists ?? this.emailExists,
        phoneExists: phoneExists ?? this.phoneExists,
      );
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase = sl<SignUpUseCase>();
  final AuthApi _authApi = sl<AuthApi>();
  SignUpNotifier() : super(const SignUpState());

  void updateName(String value) => state = state.copyWith(name: value, error: null, nameError: null);
  void updatePhone(String value) {
    state = state.copyWith(phone: value, error: null, phoneError: null, phoneExists: null);
    _debouncedCheckPhone();
  }
  void updateEmail(String value) {
    state = state.copyWith(email: value, error: null, emailError: null, emailExists: null);
    _debouncedCheckEmail();
  }
  void updatePassword(String value) => state = state.copyWith(password: value, error: null, passwordError: null);
  void updateConfirmPassword(String value) => state = state.copyWith(confirmPassword: value, error: null, confirmPasswordError: null);
  void updateLocation(String value) => state = state.copyWith(location: value, error: null, locationError: null);
  void updateIsDriver(bool value) => state = state.copyWith(isDriver: value, error: null);

  Future<void> _debouncedCheckEmail() async {
    final emailError = InputValidators.email(state.email);
    if (emailError != null) return; // do not check invalid emails
    final email = state.email;
    await Future.delayed(const Duration(milliseconds: 400));
    if (email != state.email) return; // user kept typing
    try {
      final res = await _authApi.checkEmail(email);
      final exists = (res.data as Map<String, dynamic>)['exists'] as bool;
      // Keep existing validation errors intact
      state = state.copyWith(emailExists: exists);
    } catch (_) {
      // ignore network errors for availability checks
    }
  }

  Future<void> _debouncedCheckPhone() async {
    final phoneError = InputValidators.tunisianPhone(state.phone);
    if (phoneError != null) return;
    final phone = state.phone;
    await Future.delayed(const Duration(milliseconds: 400));
    if (phone != state.phone) return;
    try {
      final res = await _authApi.checkPhone(phone);
      final exists = (res.data as Map<String, dynamic>)['exists'] as bool;
      state = state.copyWith(phoneExists: exists);
    } catch (_) {}
  }

  Future<bool> signUp() async {
    final nameError = InputValidators.requireNonEmpty(state.name, fieldName: 'Full name');
    final phoneError = InputValidators.tunisianPhone(state.phone);
    final emailError = InputValidators.email(state.email);
    final passwordError = InputValidators.passwordStrong(state.password);
    final confirmPasswordError = InputValidators.confirmPassword(state.confirmPassword, state.password);
    final locationError = InputValidators.requireNonEmpty(state.location, fieldName: 'Location');

    if ([nameError, phoneError, emailError, passwordError, confirmPasswordError, locationError].any((e) => e != null)) {
      state = state.copyWith(
        nameError: nameError,
        phoneError: phoneError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        locationError: locationError,
      );
      return false;
    }

    // If availability checks ran and returned exists, block submission
    if (state.emailExists == true) {
      state = state.copyWith(emailError: 'Email already in use');
      return false;
    }
    if (state.phone.isNotEmpty && state.phoneExists == true) {
      state = state.copyWith(phoneError: 'Phone already in use');
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