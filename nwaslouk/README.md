# Nwaslouk – Your Louage Travel Companion in Tunisia

Nwaslouk connects passengers and louage (shared taxi) drivers across Tunisia. Search and book rides by city/date, and drivers can publish trips. Built with Flutter, Clean Architecture, and testable modular components.

## Key Features
- Search & Book Trips – Filter by departure city, destination, and date
- Post a Trip – Drivers publish routes, seats, and departure time
- Real-Time Updates – Prepared for Firebase push notifications
- Secure Communication – Future in-app chat/phone handoff
- User Profiles & Ratings – Build trust with community ratings
- Multi-Language – Arabic and French (English coming soon)

## Why Nwaslouk?
- Avoid station waiting and uncertainty
- Organize and schedule rides ahead of time
- Safer, community-driven travel

---

## Tech Stack
- Flutter (Dart null safety)
- Riverpod for state management (lightweight, testable, no codegen)
- get_it for dependency injection
- Dio for HTTP
- flutter_dotenv for environment configuration (dev/staging/prod)
- logger for debugging
- dartz for functional Either
- shared_preferences for simple local storage
- Firebase-ready structure for FCM/Analytics

## Project Structure (Feature-first + Clean Architecture)
```
lib/
  core/
    di/              # get_it registrations
    env/             # environment loader
    error/           # Failure model
    logging/         # Logger wrapper
    network/         # Dio client
    routing/         # AppRouter
  domain/
    entities/        # Trip, Booking, UserProfile, AuthToken
    repositories/    # Abstract repositories
    usecases/        # Business logic
  data/
    datasources/
      remote/        # API clients (Dio)
      local/         # Local store (SharedPreferences)
      mock/          # Mock data for offline dev
    repositories_impl/ # Repository implementations
  presentation/
    app/
      localization/  # i18n (placeholder)
      nwaslouk_app.dart
    features/
      authentication/
        pages/ providers/
      search_trips/
        pages/ providers/ widgets/
      booking/
        pages/ providers/
      profile/
        pages/ providers/
```

## Getting Started
1) Prerequisites: Flutter SDK, Android Studio/Xcode, Dart 3.3+
2) Install dependencies:
```
flutter pub get
```
3) Choose environment (default dev). Run app:
```
flutter run --dart-define=ENV=dev
# or staging / prod
flutter run --dart-define=ENV=staging
```
4) Build:
```
flutter build apk --dart-define=ENV=prod
```

## Environments
- `env/.env.development`: local API, logs enabled
- `env/.env.staging`: staging API, logs enabled
- `env/.env.production`: production API, logs disabled

## State Management Choice: Riverpod
- Simple, compile-time safety, no codegen
- Great testability (override providers)
- Scales feature-first, no global singletons required in widgets

## Extending Features
- Add a new feature folder under `presentation/features/<feature>`
- Add entities/use cases in `domain` as needed
- Add API methods and repository implementation in `data`
- Register dependencies in `core/di/service_locator.dart`
- Wire UI via providers calling use cases

## Testing
- Unit tests in `test/` with mocktail
- Example: `test/domain/usecases/trip/search_trips_usecase_test.dart`

Run tests:
```
flutter test
```

## Linting
- Uses `flutter_lints` plus stricter rules in `analysis_options.yaml`

## Firebase Integration (prepared)
- Use `packages/firebase/` to add modular Firebase setup (FCM, Analytics)
- Keep Firebase-dependent code behind interfaces; inject via DI

## Mock Data / Offline Mode
- `lib/data/datasources/mock/mock_data.dart` provides basic offline data
- Repositories fall back to mock data on network errors during development

## License
Proprietary © Nwaslouk. All rights reserved.