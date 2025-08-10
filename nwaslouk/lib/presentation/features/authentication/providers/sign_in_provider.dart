import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/auth/sign_in_usecase.dart';

class SignInState {
  final String phone;
  final String otp;
  final bool isLoading;
  final String? error;

  const SignInState({
    this.phone = '',
    this.otp = '',
    this.isLoading = false,
    this.error,
  });

  SignInState copyWith({String? phone, String? otp, bool? isLoading, String? error}) =>
      SignInState(
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class SignInNotifier extends StateNotifier<SignInState> {
  final SignInUseCase _signInUseCase = sl<SignInUseCase>();
  SignInNotifier() : super(const SignInState());

  void updatePhone(String v) => state = state.copyWith(phone: v, error: null);
  void updateOtp(String v) => state = state.copyWith(otp: v, error: null);

  Future<bool> signIn() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _signInUseCase(SignInParams(phone: state.phone, otp: state.otp));
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