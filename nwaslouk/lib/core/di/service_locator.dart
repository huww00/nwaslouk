import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../env/environment.dart';
import '../logging/app_logger.dart';
import '../network/api_client.dart';

import '../../data/datasources/remote/trip_api.dart';
import '../../data/datasources/remote/auth_api.dart';
import '../../data/datasources/remote/booking_api.dart';
import '../../data/datasources/remote/profile_api.dart';
import '../../data/datasources/local/local_store.dart';
import '../../data/datasources/mock/mock_data.dart';

import '../../data/repositories_impl/trip_repository_impl.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/booking_repository_impl.dart';
import '../../data/repositories_impl/profile_repository_impl.dart';

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

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Logger
  sl.registerLazySingleton<Logger>(() => AppLogger.instance);

  // Local store
  sl.registerLazySingleton<LocalStore>(() => LocalStore());

  // Dio client (inject Authorization header via token provider)
  sl.registerLazySingleton<Dio>(() => ApiClient.createDio(
        baseUrl: Environment.current.apiBaseUrl,
        tokenProvider: () => sl<LocalStore>().getAuthToken(),
      ));

  // Mock data (for offline dev)
  sl.registerLazySingleton<MockData>(() => MockData());

  // APIs
  sl.registerLazySingleton<TripApi>(() => TripApi(sl<Dio>()));
  sl.registerLazySingleton<AuthApi>(() => AuthApi(sl<Dio>()));
  sl.registerLazySingleton<BookingApi>(() => BookingApi(sl<Dio>()));
  sl.registerLazySingleton<ProfileApi>(() => ProfileApi(sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<TripRepository>(() => TripRepositoryImpl(api: sl<TripApi>(), mockData: sl<MockData>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(api: sl<AuthApi>(), localStore: sl<LocalStore>()));
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(api: sl<BookingApi>(), mockData: sl<MockData>()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(api: sl<ProfileApi>(), localStore: sl<LocalStore>(), mockData: sl<MockData>()));

  // Use cases
  sl.registerFactory<SearchTripsUseCase>(() => SearchTripsUseCase(sl<TripRepository>()));
  sl.registerFactory<PublishTripUseCase>(() => PublishTripUseCase(sl<TripRepository>()));
  sl.registerFactory<BookSeatUseCase>(() => BookSeatUseCase(sl<BookingRepository>()));
  sl.registerFactory<SignInUseCase>(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerFactory<SignUpUseCase>(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerFactory<GetProfileUseCase>(() => GetProfileUseCase(sl<ProfileRepository>()));
}