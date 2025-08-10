import 'package:flutter/material.dart';
import '../../presentation/features/authentication/pages/sign_in_page.dart';
import '../../presentation/app/splash/splash_page.dart';
import '../../presentation/app/home/home_shell.dart';
import '../../presentation/features/search_trips/pages/search_trips_page.dart';
import '../../presentation/features/booking/pages/booking_page.dart';
import '../../presentation/features/profile/pages/profile_page.dart';

class AppRouter {
  static const String initialRoute = SplashPage.routeName;

  static Map<String, WidgetBuilder> get routes => {
        SplashPage.routeName: (_) => const SplashPage(),
        HomeShell.routeName: (_) => const HomeShell(),
        SignInPage.routeName: (_) => const SignInPage(),
        SearchTripsPage.routeName: (_) => const SearchTripsPage(),
        BookingPage.routeName: (_) => const BookingPage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
      };
}