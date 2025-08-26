# Google Authentication Setup Guide

This guide will help you set up Google authentication for both your Node.js backend and Flutter frontend.

## Prerequisites

- Google Cloud Console account
- Node.js backend running
- Flutter app configured

## Backend Setup (Node.js)

### 1. Install Dependencies

The required dependencies have already been added to your `package.json`:

```bash
cd backend_nwaslouk
npm install
```

### 2. Google Cloud Console Configuration

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Google+ API and Google Sign-In API
4. Go to "Credentials" → "Create Credentials" → "OAuth 2.0 Client IDs"
5. Choose "Web application" for backend
6. Add authorized redirect URIs:
   - `http://localhost:3000/auth/google/callback` (for development)
   - Your production domain (for production)
7. Copy the Client ID and Client Secret

### 3. Environment Configuration

Create a `.env` file in your backend directory:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# MongoDB Connection
MONGODB_URI=mongodb://localhost:27017/nwaslouk

# JWT Configuration
JWT_SECRET=your_super_secret_jwt_key_here
JWT_EXPIRES_IN=7d

# Google OAuth Configuration
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
```

### 4. Database Schema Updates

The User model has been updated to support Google authentication:
- `googleId`: Stores Google's unique user identifier
- `authProvider`: Indicates whether user signed up with 'local' or 'google'
- `passwordHash`: Made optional for Google users

### 5. New API Endpoints

- `POST /auth/google` - Google Sign-In endpoint
- Updated existing endpoints to handle Google users

## Flutter Frontend Setup

### 1. Install Dependencies

The required dependencies have been added to your `pubspec.yaml`:

```bash
cd nwaslouk
flutter pub get
```

### 2. Android Configuration

#### Update `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        // ... other config
        minSdkVersion 21  // Required for Google Sign-In
    }
}
```

#### Update `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
    <uses-permission android:name="android.permission.INTERNET" />
    
    <application ...>
        <!-- ... other config -->
        
        <!-- Google Sign-In configuration -->
        <meta-data
            android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" />
    </application>
</manifest>
```

### 3. iOS Configuration

#### Update `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>google</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

#### Update `ios/Runner/GoogleService-Info.plist`:

Download this file from Google Cloud Console and place it in the iOS Runner directory.

### 4. Google Cloud Console - Android/iOS Configuration

1. Go to Google Cloud Console → Credentials
2. Create OAuth 2.0 Client IDs for:
   - Android (with your package name and SHA-1 fingerprint)
   - iOS (with your bundle ID)

### 5. Environment Configuration

Create a `.env` file in your Flutter project:

```env
# Backend API URL
BACKEND_URL=http://localhost:3000

# Google Sign-In Configuration
GOOGLE_CLIENT_ID_ANDROID=your_android_client_id
GOOGLE_CLIENT_ID_IOS=your_ios_client_id
```

## Architecture Overview

### Backend Architecture

```
User Model (MongoDB)
├── Local Authentication
│   ├── email + passwordHash
│   └── authProvider: 'local'
└── Google Authentication
    ├── email + googleId
    └── authProvider: 'google'
```

### Frontend Architecture

```
AuthScreen
├── Local Authentication Form
│   ├── Email/Password
│   └── Sign Up/In
└── Google Sign-In
    └── Google OAuth Flow
```

### Data Flow

1. **Google Sign-In Flow**:
   - User taps "Continue with Google"
   - Flutter opens Google Sign-In
   - Google returns ID token
   - Token sent to backend `/auth/google`
   - Backend verifies token with Google
   - Backend creates/updates user
   - JWT token returned to Flutter
   - User authenticated

2. **Local Authentication Flow**:
   - User enters email/password
   - Credentials sent to backend
   - Backend validates and returns JWT
   - User authenticated

## Testing

### Backend Testing

```bash
cd backend_nwaslouk
npm run dev
```

Test the Google endpoint:
```bash
curl -X POST http://localhost:3000/auth/google \
  -H "Content-Type: application/json" \
  -d '{"idToken": "your_google_id_token"}'
```

### Frontend Testing

```bash
cd nwaslouk
flutter run
```

## Security Considerations

1. **JWT Secret**: Use a strong, unique JWT secret
2. **HTTPS**: Always use HTTPS in production
3. **Token Expiration**: Set appropriate JWT expiration times
4. **Input Validation**: Validate all user inputs
5. **Rate Limiting**: Implement rate limiting for auth endpoints

## Troubleshooting

### Common Issues

1. **Google Sign-In not working**:
   - Check Google Cloud Console configuration
   - Verify client IDs match
   - Check SHA-1 fingerprints for Android

2. **Backend connection errors**:
   - Verify backend is running
   - Check CORS configuration
   - Verify environment variables

3. **Authentication state not persisting**:
   - Check SharedPreferences implementation
   - Verify token storage/retrieval

### Debug Mode

Enable debug logging in your Flutter app:

```dart
GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  signInOption: SignInOption.standard,
);
```

## Production Deployment

1. Update environment variables with production values
2. Use HTTPS for all API calls
3. Set up proper CORS for your domain
4. Configure Google OAuth for production domains
5. Use environment-specific Google client IDs

## Support

For additional help:
- [Google Sign-In Flutter Plugin](https://pub.dev/packages/google_sign_in)
- [Google OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2)
- [Flutter Authentication Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)