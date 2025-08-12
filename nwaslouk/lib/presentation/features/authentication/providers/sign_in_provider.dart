import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/sign_in_usecase.dart';

class SignInState {
  final String identifier; // email or phone
  final String password;
  final bool isLoading;
  final String? error;

  const SignInState({
    this.identifier = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  SignInState copyWith({String? identifier, String? password, bool? isLoading, String? error}) =>
      SignInState(
        identifier: identifier ?? this.identifier,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class SignInNotifier extends StateNotifier<SignInState> {
  final SignInUseCase _signInUseCase = sl<SignInUseCase>();
  SignInNotifier() : super(const SignInState());

  void updateIdentifier(String v) => state = state.copyWith(identifier: v, error: null);
  void updatePassword(String v) => state = state.copyWith(password: v, error: null);

  Future<bool> signIn() async {
    state = state.copyWith(isLoading: true, error: null);
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