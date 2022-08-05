import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/view/bottom_bar/bottom_navigation_bar.dart';
import 'package:beehive/view/dashboard/app_settings.dart';
import 'package:beehive/view/dashboard/archived_projects_screen.dart';
import 'package:beehive/view/dashboard/notifications_screen.dart';
import 'package:beehive/view/dashboard/select_to_continue_screen.dart';
import 'package:beehive/view/email_address_screen.dart';
import 'package:beehive/view/introduction/beehive_introduction.dart';
import 'package:beehive/view/introduction/introduction_pages.dart';
import 'package:beehive/view/sign_in/sign_in_screen.dart';
import 'package:beehive/view/timesheets/timesheets_screen.dart';
import 'package:flutter/material.dart';

class OnGenerateRouter {

  static Route<dynamic> onGenerate(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.beehiveIntro:
        return MaterialPageRoute(
            builder: (_) => IntroductionPages(), settings: settings);

      case RouteConstants.signInScreen:
        return MaterialPageRoute(
            builder: (_) => SignInScreen(), settings: settings);

      case RouteConstants.bottomNavigationBar:
        return MaterialPageRoute(
            builder: (_) => BottomBar(), settings: settings);

      case RouteConstants.timeSheetsScreen:
        return MaterialPageRoute(
            builder: (_) => TimeSheetsScreen(), settings: settings);

      case RouteConstants.notificationsScreen:
        return MaterialPageRoute(
            builder: (_) => NotificationsScreen(), settings: settings);

      case RouteConstants.archivedProjectsScreen:
        return MaterialPageRoute(
            builder: (_) => ArchivedProjectsScreen(), settings: settings);

      case RouteConstants.appSettings:
        return MaterialPageRoute(
            builder: (_) => AppSettings(), settings: settings);

      case RouteConstants.selectToContinueScreen:
        return MaterialPageRoute(
            builder: (_) => SelectToContinueScreen(), settings: settings);

      case RouteConstants.emailAddressScreen:
        return MaterialPageRoute(
            builder: (_) => EmailAddressScreen(), settings: settings);

      default:
        return _onPageNotFound();
    }
  }

  static Route<dynamic> _onPageNotFound() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      ),
    );
  }
}
