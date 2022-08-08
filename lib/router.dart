import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/view/bottom_bar/bottom_navigation_bar.dart';
import 'package:beehive/view/dashboard/app_settings.dart';
import 'package:beehive/view/dashboard/archived_projects_screen.dart';
import 'package:beehive/view/dashboard/notifications_screen.dart';
import 'package:beehive/view/dashboard/select_to_continue_screen.dart';
import 'package:beehive/view/light_theme_signup_login/email_address_screen.dart';
import 'package:beehive/view/introduction/beehive_introduction.dart';
import 'package:beehive/view/introduction/introduction_pages.dart';
import 'package:beehive/view/light_theme_signup_login/login_screen.dart';
import 'package:beehive/view/light_theme_signup_login/reset_password_screen.dart';
import 'package:beehive/view/light_theme_signup_login/sign_up_screen.dart';
import 'package:beehive/view/profile/certification_page.dart';
import 'package:beehive/view/profile/change_password_page.dart';
import 'package:beehive/view/profile/edit_profile_page.dart';
import 'package:beehive/view/projects/add_note_page.dart';
import 'package:beehive/view/projects/crew_profile_page.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/view/projects/project_settings_page.dart';
import 'package:beehive/view/sign_in/sign_in_screen.dart';
import 'package:beehive/view/timesheets/timesheets_screen.dart';
import 'package:beehive/view/upgrade_crew_manager/payment_page.dart';
import 'package:beehive/view/upgrade_crew_manager/upgrade_page.dart';
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
      case RouteConstants.projectDetailsPage:
        return MaterialPageRoute(
            builder: (_) => ProjectDetailsPage(), settings: settings);
      case RouteConstants.addNotePage:
        return MaterialPageRoute(
            builder: (_) => AddNotePage(), settings: settings);
      case RouteConstants.projectSettingsPage:
        return MaterialPageRoute(
            builder: (_) => ProjectSettingsPage(), settings: settings);
      case RouteConstants.crewProfilePage:
        return MaterialPageRoute(
            builder: (_) => CrewProfilePage(), settings: settings);
      case RouteConstants.editProfilePage:
        return MaterialPageRoute(
            builder: (_) => EditProfilePage(), settings: settings);
      case RouteConstants.changePasswordPage:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordPage(), settings: settings);
      case RouteConstants.certificationPage:
        return MaterialPageRoute(
            builder: (_) => CertificationPage(), settings: settings);
      case RouteConstants.upgradePage:
        return MaterialPageRoute(
            builder: (_) => UpgradePage(), settings: settings);
      case RouteConstants.paymentPage:
        return MaterialPageRoute(
            builder: (_) => PaymentPage(), settings: settings);

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
            builder: (_) => EmailAddressScreen(fromForgotPassword: args == null ? false : args as bool,), settings: settings);

      case RouteConstants.signUpScreen:
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(email: args as String), settings: settings);

      case RouteConstants.loginScreen:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);

      case RouteConstants.resetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(), settings: settings);

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
