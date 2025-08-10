import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/usecases/profile/get_profile_usecase.dart';
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
  ProfileNotifier() : super(const ProfileState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    final res = await _useCase();
    res.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.message),
      (r) => state = state.copyWith(isLoading: false, profile: r),
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) => ProfileNotifier());