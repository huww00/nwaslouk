# Firebase Module (Optional)

Keep Firebase isolated here to maintain modularity.

Suggested setup:
- Add `firebase_core`, `firebase_messaging`, `firebase_analytics` to this package or the main app when needed
- Create abstract interfaces in `lib/` and concrete Firebase implementations here
- Inject implementations via `get_it` in `core/di/service_locator.dart`

Example interfaces:
- PushNotificationsService (requestPermission, getToken, onMessage)
- AnalyticsService (logEvent, setUserId)

This keeps the main app decoupled from Firebase specifics and makes testing easier.