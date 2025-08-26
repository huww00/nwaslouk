import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env/environment.dart';
import '../logging/app_logger.dart';
import '../network/api_client.dart';

import '../../data/datasources/remote/trip_api.dart';
import '../../data/datasources/remote/auth_api.dart';
import '../../data/datasources/remote/booking_api.dart';
import '../../data/datasources/remote/profile_api.dart';
import '../../data/datasources/local/local_store.dart';
import '../../data/datasources/mock/mock_data.dart';

// New Google Auth data sources
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_local_data_source.dart';

import '../../data/repositories_impl/trip_repository_impl.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/booking_repository_impl.dart';
import '../../data/repositories_impl/profile_repository_impl.dart';

// New Google Auth repository
import '../../data/repositories/auth_repository_impl.dart' as google_auth;

import '../../domain/repositories/trip_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/repositories/profile_repository.dart';

import '../../domain/usecases/trip/search_trips_usecase.dart';
import '../../domain/usecases/trip/publish_trip_usecase.dart';
import '../../domain/usecases/booking/book_seat_usecase.dart';
import '../../domain/usecases/auth/sign_in_usecase.dart';
import '../../domain/usecases/auth/sign_up_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/profile/get_profile_usecase.dart';
import '../../domain/usecases/profile/update_profile_usecase.dart';

// New Google Auth use cases
import '../../domain/usecases/auth_usecases.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Logger
  sl.registerLazySingleton<Logger>(() => AppLogger.instance);

  // Dio client
  sl.registerLazySingleton<Dio>(() => ApiClient.createDio(baseUrl: Environment.current.apiBaseUrl));

  // Local store
  sl.registerLazySingleton<LocalStore>(() => LocalStore());

  // Mock data (for offline dev)
  sl.registerLazySingleton<MockData>(() => MockData());

  // Google Sign-In
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(
    scopes: ['email', 'profile'],
  ));

  // Shared Preferences for auth token storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // APIs
  sl.registerLazySingleton<TripApi>(() => TripApi(sl<Dio>()));
  sl.registerLazySingleton<AuthApi>(() => AuthApi(sl<Dio>()));
  sl.registerLazySingleton<BookingApi>(() => BookingApi(sl<Dio>()));
  sl.registerLazySingleton<ProfileApi>(() => ProfileApi(sl<Dio>()));

  // New Google Auth data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dio: sl<Dio>(),
      googleSignIn: sl<GoogleSignIn>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<TripRepository>(() => TripRepositoryImpl(api: sl<TripApi>(), mockData: sl<MockData>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(api: sl<AuthApi>(), localStore: sl<LocalStore>()));
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(api: sl<BookingApi>(), mockData: sl<MockData>()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(api: sl<ProfileApi>(), localStore: sl<LocalStore>(), mockData: sl<MockData>()));

  // New Google Auth repository (alias to avoid conflicts)
  sl.registerLazySingleton<google_auth.AuthRepository>(
    () => google_auth.AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Use cases
  sl.registerFactory<SearchTripsUseCase>(() => SearchTripsUseCase(sl<TripRepository>()));
  sl.registerFactory<PublishTripUseCase>(() => PublishTripUseCase(sl<TripRepository>()));
  sl.registerFactory<BookSeatUseCase>(() => BookSeatUseCase(sl<BookingRepository>()));
  sl.registerFactory<SignInUseCase>(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerFactory<SignUpUseCase>(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerFactory<GetProfileUseCase>(() => GetProfileUseCase(sl<ProfileRepository>()));
  sl.registerFactory<UpdateProfileUseCase>(() => UpdateProfileUseCase(sl<ProfileRepository>()));

  // New Google Auth use cases
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<google_auth.AuthRepository>()),
  );

  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl<google_auth.AuthRepository>()),
  );

  sl.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(sl<google_auth.AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<google_auth.AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<google_auth.AuthRepository>()),
  );

  sl.registerLazySingleton<IsAuthenticatedUseCase>(
    () => IsAuthenticatedUseCase(sl<google_auth.AuthRepository>()),
  );
}