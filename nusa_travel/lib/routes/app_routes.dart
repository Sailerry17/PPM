import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';

  /// Route statis (tanpa arguments).
  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        home: (_) => const HomeScreen(),
      };

  /// Route dinamis (membutuhkan arguments).
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final args = settings.arguments;
      if (args is TourPackage) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DetailScreen(tourPackage: args),
        );
      }
      // Arguments tidak valid -> tampilkan 404
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => NotFoundScreen(routeName: settings.name),
      );
    }
    // null => diteruskan ke onUnknownRoute
    return null;
  }

  /// Dipanggil jika route tidak ditemukan.
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => NotFoundScreen(routeName: settings.name),
    );
  }
}
