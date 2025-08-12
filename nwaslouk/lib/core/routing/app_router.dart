import 'package:flutter/material.dart';
import '../../presentation/features/authentication/pages/sign_in_page.dart';
import '../../presentation/features/authentication/pages/sign_up_page.dart';
import '../../presentation/features/search_trips/pages/search_trips_page.dart';
import '../../presentation/features/booking/pages/booking_page.dart';
import '../../presentation/features/profile/pages/profile_page.dart';
import '../../presentation/features/authentication/pages/success_page.dart';

class AppRouter {
  static const String initialRoute = SignInPage.routeName;

  static Map<String, WidgetBuilder> get routes => {
        SignInPage.routeName: (_) => const SignInPage(),
        SignUpPage.routeName: (_) => const SignUpPage(),
        AuthSuccessPage.routeName: (_) => const AuthSuccessPage(),
        SearchTripsPage.routeName: (_) => const SearchTripsPage(),
        BookingPage.routeName: (_) => const BookingPage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
      };
}