import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/injection.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/usecases/auth_usecases.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    signUpUseCase: getIt<SignUpUseCase>(),
    signInUseCase: getIt<SignInUseCase>(),
    signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;

  AuthNotifier({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signInWithGoogleUseCase,
    required this.logoutUseCase,
  }) : super(const AuthState.initial());

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  }) async {
    state = const AuthState.loading();
    
    try {
      final result = await signUpUseCase(
        email: email,
        password: password,
        name: name,
        phone: phone,
        location: location,
        isDriver: isDriver,
      );
      
      result.fold(
        (failure) => state = AuthState.error(failure),
        (token) => state = AuthState.authenticated(token),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    state = const AuthState.loading();
    
    try {
      final result = await signInUseCase(
        email: email,
        phone: phone,
        password: password,
      );
      
      result.fold(
        (failure) => state = AuthState.error(failure),
        (token) => state = AuthState.authenticated(token),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    
    try {
      final result = await signInWithGoogleUseCase();
      
      result.fold(
        (failure) => state = AuthState.error(failure),
        (token) => state = AuthState.authenticated(token),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCase();
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void clearError() {
    if (state is AuthError) {
      state = const AuthState.initial();
    }
  }
}

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final String token;
  final AuthUser? user;

  const AuthAuthenticated(this.token, [this.user]);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

// Extension for easier state checking
extension AuthStateExtension on AuthState {
  bool get isInitial => this is AuthInitial;
  bool get isLoading => this is AuthLoading;
  bool get isAuthenticated => this is AuthAuthenticated;
  bool get isError => this is AuthError;
  
  String? get token => this is AuthAuthenticated ? (this as AuthAuthenticated).token : null;
  AuthUser? get user => this is AuthAuthenticated ? (this as AuthAuthenticated).user : null;
  String? get errorMessage => this is AuthError ? (this as AuthError).message : null;
}