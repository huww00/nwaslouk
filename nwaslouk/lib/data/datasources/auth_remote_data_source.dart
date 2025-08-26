import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/auth_user.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  });

  Future<String> signIn({
    String? email,
    String? phone,
    required String password,
  });

  Future<String> signInWithGoogle();
  Future<AuthUser> getCurrentUser(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.dio,
    required this.googleSignIn,
  });

  @override
  Future<String> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  }) async {
    try {
      final response = await dio.post('/auth/sign-up', data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'location': location,
        'isDriver': isDriver,
      });

      return response.data['token'];
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw 'Email or phone already in use';
      }
      throw 'Sign up failed: ${e.response?.data?['message'] ?? 'Unknown error'}';
    }
  }

  @override
  Future<String> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      final response = await dio.post('/auth/sign-in', data: {
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'password': password,
      });

      return response.data['token'];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw 'Invalid credentials';
      }
      throw 'Sign in failed: ${e.response?.data?['message'] ?? 'Unknown error'}';
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      // Start Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign in was cancelled';
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'Failed to get Google ID token';
      }

      // Send token to backend
      final response = await dio.post('/auth/google', data: {
        'idToken': idToken,
      });

      return response.data['token'];
    } on DioException catch (e) {
      throw 'Google sign in failed: ${e.response?.data?['message'] ?? 'Unknown error'}';
    } catch (e) {
      throw 'Google sign in failed: $e';
    }
  }

  @override
  Future<AuthUser> getCurrentUser(String token) async {
    try {
      final response = await dio.get('/profile/me', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));

      return AuthUser.fromJson(response.data);
    } on DioException catch (e) {
      throw 'Failed to get user profile: ${e.response?.data?['message'] ?? 'Unknown error'}';
    }
  }
}