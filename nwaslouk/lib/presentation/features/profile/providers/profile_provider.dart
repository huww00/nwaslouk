import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/usecases/profile/get_profile_usecase.dart';
import '../../../../domain/usecases/profile/update_profile_usecase.dart';
import '../../../../domain/usecases/profile/change_password_usecase.dart';
import '../../../../core/di/service_locator.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserProfile? profile;

  const ProfileState({this.isLoading = false, this.error, this.profile});

  ProfileState copyWith({bool? isLoading, String? error, UserProfile? profile}) =>
      ProfileState(isLoading: isLoading ?? this.isLoading, error: error, profile: profile ?? this.profile);
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetProfileUseCase _useCase = sl<GetProfileUseCase>();
  final UpdateProfileUseCase _updateUseCase = sl<UpdateProfileUseCase>();
  final ChangePasswordUseCase _changePasswordUseCase = sl<ChangePasswordUseCase>();
  ProfileNotifier() : super(const ProfileState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    final res = await _useCase();
    res.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.message),
      (r) => state = state.copyWith(isLoading: false, profile: r),
    );
  }

  Future<void> update({String? name, String? phone, String? location, bool? isDriver, String? email}) async {
    state = state.copyWith(isLoading: true, error: null);
    final res = await _updateUseCase(name: name, phone: phone, location: location, isDriver: isDriver, email: email);
    res.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.message),
      (r) => state = state.copyWith(isLoading: false, profile: r),
    );
  }

  Future<String?> changePassword({required String currentPassword, required String newPassword}) async {
    state = state.copyWith(isLoading: true, error: null);
    final res = await _changePasswordUseCase(currentPassword: currentPassword, newPassword: newPassword);
    return res.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.message);
        return l.message;
      },
      (r) {
        state = state.copyWith(isLoading: false);
        return null;
      },
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) => ProfileNotifier());