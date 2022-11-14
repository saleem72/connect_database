//

import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:flutter/material.dart';

import '../../screens/main_screens.dart';

class RouteGenerator {
  static Route<dynamic>? generate(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Navlinks.initial:
        return MaterialPageRoute(builder: (context) => const LandingScreen());
      case Navlinks.executingSql:
        return MaterialPageRoute(
            builder: (context) => const ExecutingSqlScreen());
      case Navlinks.sqlResult:
        if (arguments is List<Map<String, String>>) {
          return MaterialPageRoute(
              builder: (context) => SqlResultScreen(
                    records: arguments,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => RoutingErrorScreen(
                  error: 'invalid argument for ${settings.name}'));
        }
      case Navlinks.recordDetails:
        if (arguments is Map<String, String>) {
          return MaterialPageRoute(
              builder: (context) => RecordDetailsScreen(
                    record: arguments,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => RoutingErrorScreen(
                  error: 'invalid argument for ${settings.name}'));
        }
      case Navlinks.barcodeScan:
        return MaterialPageRoute(
            builder: (context) => const BarcodeScanScreen());

      case Navlinks.barcodeScanResult:
        if (arguments is String) {
          return MaterialPageRoute(
              builder: (context) => BarcodeScanResult(
                    barcode: arguments,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => RoutingErrorScreen(
                  error: 'invalid argument for ${settings.name}'));
        }
      default:
        return MaterialPageRoute(
            builder: (context) => RoutingErrorScreen(
                error: '${settings.name} is not valid route'));
    }
  }
}
