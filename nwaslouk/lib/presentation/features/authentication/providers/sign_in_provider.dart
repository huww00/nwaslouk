import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/sign_in_usecase.dart';
import '../../../../core/validation/input_validators.dart';

class SignInState {
  final String identifier;
  final String password;
  final bool isLoading;
  final String? error;
  final String? identifierError;
  final String? passwordError;

  const SignInState({
    this.identifier = '',
    this.password = '',
    this.isLoading = false,
    this.error,
    this.identifierError,
    this.passwordError,
  });

  SignInState copyWith({
    String? identifier,
    String? password,
    bool? isLoading,
    String? error,
    String? identifierError,
    String? passwordError,
  }) =>
      SignInState(
        identifier: identifier ?? this.identifier,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        identifierError: identifierError,
        passwordError: passwordError,
      );
}

class SignInNotifier extends StateNotifier<SignInState> {
  final SignInUseCase _signInUseCase = sl<SignInUseCase>();
  SignInNotifier() : super(const SignInState());

  void updateIdentifier(String value) => state = state.copyWith(identifier: value, error: null, identifierError: null);
  void updatePassword(String value) => state = state.copyWith(password: value, error: null, passwordError: null);

  Future<bool> signIn() async {
    final identifierError = InputValidators.identifierEmailOrPhone(state.identifier);
    final passwordError = state.password.isEmpty ? 'Password is required' : null;
    if (identifierError != null || passwordError != null) {
      state = state.copyWith(identifierError: identifierError, passwordError: passwordError);
      return false;
    }

    state = state.copyWith(isLoading: true, error: null, identifierError: null, passwordError: null);
    final result = await _signInUseCase(SignInParams(identifier: state.identifier, password: state.password));
    return result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      return false;
    }, (r) {
      state = state.copyWith(isLoading: false);
      return true;
    });
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>((ref) => SignInNotifier());