import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/model/get_profile_response_manager.dart' as manager_cert;
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/project_detail_crew_response.dart';
import 'package:beehive/model/project_detail_manager_response.dart' as manager_note;
import 'package:beehive/view/%20light_theme_signup_login/continue_with_phone.dart';
import 'package:beehive/view/%20light_theme_signup_login/otp_verification_page.dart';
import 'package:beehive/view/bottom_bar/bottom_navigation_bar.dart';
import 'package:beehive/view/dashboard/app_settings.dart';
import 'package:beehive/view/dashboard/archived_projects_screen.dart';
import 'package:beehive/view/dashboard/notifications_screen.dart';
import 'package:beehive/view/dashboard/select_to_continue_screen.dart';
import 'package:beehive/view/introduction/beehive_introduction.dart';
import 'package:beehive/view/introduction/introduction_pages.dart';
import 'package:beehive/view/light_theme_signup_login/email_address_screen.dart';
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
import 'package:beehive/view/projects/show_note_page_crew.dart';
import 'package:beehive/view/sign_in/sign_in_screen.dart';
import 'package:beehive/view/timesheets/timesheets_screen.dart';
import 'package:beehive/view/upgrade_crew_manager/payment_page.dart';
import 'package:beehive/view/upgrade_crew_manager/upgrade_page.dart';
import 'package:beehive/views_manager/billing_information/billing_information_page_manager.dart';
import 'package:beehive/views_manager/bottom_bar_manager/bottom_navigation_bar_manager.dart';
import 'package:beehive/views_manager/dashboard_manager/app_settings_manager.dart';
import 'package:beehive/views_manager/dashboard_manager/archived_projects_screen_manager.dart';
import 'package:beehive/views_manager/dashboard_manager/notifications_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/continue_with_phone_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/email_address_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/login_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/reset_password_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/sign_up_screen_manager.dart';
import 'package:beehive/views_manager/profile_manager/certification_page_manager.dart';
import 'package:beehive/views_manager/profile_manager/change_password_page_manager.dart';
import 'package:beehive/views_manager/profile_manager/edit_profile_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/add_crew_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/add_note_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/archived_project_details_manager.dart';
import 'package:beehive/views_manager/projects_manager/create_project_manager.dart';
import 'package:beehive/views_manager/projects_manager/crew_mamber_add_by_manager.dart';
import 'package:beehive/views_manager/projects_manager/crew_profile_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/project_details_manager.dart';
import 'package:beehive/views_manager/projects_manager/project_setting_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/set_rates_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/show_note_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/timesheets_screen_manager.dart';
import 'package:beehive/views_manager/billing_information/payment_page_manager.dart';
import 'package:beehive/views_manager/timesheet_manager/timesheet_from_crew.dart';
import 'package:beehive/widget/autoCompletePlaces.dart';
import 'package:beehive/views_manager/profile_manager/show_cerfication_manager_page.dart';
import 'package:flutter/material.dart';

class OnGenerateRouter {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.beehiveIntro:
        return MaterialPageRoute(
            builder: (_) => const IntroductionPages(), settings: settings);

      case RouteConstants.signInScreen:
        return MaterialPageRoute(
            builder: (_) => const SignInScreen(), settings: settings);

      case RouteConstants.bottomNavigationBar:
        return MaterialPageRoute(
            builder: (_) => const BottomBar(), settings: settings);
      case RouteConstants.projectDetailsPage:
        final args = settings.arguments as ProjectDetailsPage;
        return MaterialPageRoute(
            builder: (_) =>
                ProjectDetailsPage(archivedOrProject: args.archivedOrProject,projectId: args.projectId,totalHoursToDate: args.totalHoursToDate,),
            settings: settings);
      case RouteConstants.addNotePage:
        return MaterialPageRoute(
            builder: (_) => const AddNotePage(), settings: settings);
      case RouteConstants.projectSettingsPage:
        return MaterialPageRoute(
            builder: (_) => const ProjectSettingsPage(), settings: settings);
      case RouteConstants.crewProfilePage:
        return MaterialPageRoute(
            builder: (_) => const CrewProfilePage(), settings: settings);
      case RouteConstants.editProfilePage:
        return MaterialPageRoute(
            builder: (_) => const EditProfilePage(), settings: settings);
      case RouteConstants.changePasswordPage:
        return MaterialPageRoute(
            builder: (_) => const ChangePasswordPage(), settings: settings);
      case RouteConstants.certificationPage:
        return MaterialPageRoute(
            builder: (_) => const CertificationPage(), settings: settings);
      case RouteConstants.upgradePage:
        return MaterialPageRoute(
            builder: (_) => const UpgradePage(), settings: settings);
      case RouteConstants.paymentPage:
        return MaterialPageRoute(
            builder: (_) => const PaymentPage(), settings: settings);

      case RouteConstants.timeSheetsScreen:
        return MaterialPageRoute(
            builder: (_) => const TimeSheetsScreen(), settings: settings);

      case RouteConstants.notificationsScreen:
        return MaterialPageRoute(
            builder: (_) => const NotificationsScreen(), settings: settings);

      case RouteConstants.archivedProjectsScreen:
        return MaterialPageRoute(
            builder: (_) => const ArchivedProjectsScreen(), settings: settings);

      case RouteConstants.appSettings:
        return MaterialPageRoute(
            builder: (_) => AppSettings(), settings: settings);

      case RouteConstants.selectToContinueScreen:
        return MaterialPageRoute(
            builder: (_) => const SelectToContinueScreen(), settings: settings);

      case RouteConstants.emailAddressScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => EmailAddressScreen(
                  isVerificationProcess: args["isVerificationProcess"],
                  email: args["email"] ?? "",
                  isResetPassword: args["isResetPassword"] ?? "",
                ),
            settings: settings);
      case RouteConstants.signUpScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(email: args), settings: settings);
      case RouteConstants.loginScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  email: args,
                ),
            settings: settings);
      case RouteConstants.resetPasswordScreen:
        final authToken = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
                  authToken: authToken,
                ),
            settings: settings);
      case RouteConstants.continueWithPhone:
        final args = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => ContinueWithPhone(
                  isResetPassword: args,
                ),
            settings: settings);
      case RouteConstants.otpVerificationPage:
        var values = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => OtpVerificationPage(
                  value: values["value"],
                  isEmailVerification: values["isEmailVerification"],
                  isResetPassword: values["isResetPassword"],
                ),
            settings: settings);
      case RouteConstants.bottomBarManager:
        var pageIndex = 0;
        var fromBottomNav = 1;
        if (settings.arguments != null) {
          final args = settings.arguments as BottomBarManager;
          fromBottomNav = args.fromBottomNav!;
          pageIndex = args.pageIndex!;
        }
        return MaterialPageRoute(
            builder: (_) => BottomBarManager(
                fromBottomNav: fromBottomNav, pageIndex: pageIndex),
            settings: settings);
      case RouteConstants.continueWithPhoneManager:
        final args = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => ContinueWithPhoneManager(
                  isResetPassword: args,
                ),
            settings: settings);
      case RouteConstants.otpVerificationPageManager:
        var values = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => OtpVerificationPageManager(
                  value: values["value"],
                  isEmailVerification: values["isEmailVerification"],
                  isResetPassword: values["isResetPassword"],
                ),
            settings: settings);
      case RouteConstants.signUpScreenManager:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SignUpScreenManager(email: args),
            settings: settings);
      case RouteConstants.emailAddressScreenManager:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => EmailAddressScreenManager(
                  isVerificationProcess: args["isVerificationProcess"],
                  email: args["email"] ?? "",
                  isResetPassword: args["isResetPassword"] ?? "",
                ),
            settings: settings);
      case RouteConstants.notificationsScreenManager:
        return MaterialPageRoute(
            builder: (_) => const NotificationsScreenManager(),
            settings: settings);
      case RouteConstants.appSettingsManager:
        return MaterialPageRoute(
            builder: (_) => AppSettingsManager(), settings: settings);
      case RouteConstants.loginScreenManager:
        final email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => LoginScreenManager(
                  email: email,
                ),
            settings: settings);
      case RouteConstants.projectDetailsPageManager:
        final args = settings.arguments as ProjectDetailsPageManager;
        return MaterialPageRoute(
            builder: (_) => ProjectDetailsPageManager(
                  createProject: args.createProject,
                  projectId: args.projectId,
                ),
            settings: settings);
      case RouteConstants.archivedProjectsScreenManager:
        return MaterialPageRoute(
            builder: (_) => const ArchivedProjectsScreenManager(),
            settings: settings);
      case RouteConstants.createProjectManager:
        return MaterialPageRoute(
            builder: (_) => CreateProjectManager(), settings: settings);
      case RouteConstants.addCrewPageManager:
        List<CrewMemberDetail>? list;
        var projectId="";
        if (settings.arguments != null) {
          var args = settings.arguments as AddCrewPageManager;
          list = args.crewList!.cast<CrewMemberDetail>();
          projectId = args.projectId!;
        }
        return MaterialPageRoute(
            builder: (_) => AddCrewPageManager(crewList: list,projectId: projectId,),
            settings: settings);
      case RouteConstants.crewMemberAddByManager:
        final args = settings.arguments as CrewMemberAddByManager;
        return MaterialPageRoute(
            builder: (_) => CrewMemberAddByManager(
                  projectId: args.projectId,
                ),
            settings: settings);
      case RouteConstants.setRatesManager:
        final args = settings.arguments as SetRatesPageManager;
        return MaterialPageRoute(
            builder: (_) => SetRatesPageManager(isUpdating: args.isUpdating,projectId: args.projectId,),
            settings: settings);
      case RouteConstants.projectSettingsPageManager:
        final args = settings.arguments as ProjectSettingsPageManager;
        return MaterialPageRoute(
            builder: (_) => ProjectSettingsPageManager(
                fromProjectOrCreateProject: args.fromProjectOrCreateProject),
            settings: settings);
      case RouteConstants.addNotePageManager:
        final args = settings.arguments as AddNotePageManager;
        return MaterialPageRoute(
            builder: (_) => AddNotePageManager(
                  isPrivate: args.isPrivate,
                  projectId: args.projectId,
                ),
            settings: settings);
      case RouteConstants.archivedProjectDetailsManager:
        final args = settings.arguments as ArchivedProjectDetailsManager;
        return MaterialPageRoute(
            builder: (_) => ArchivedProjectDetailsManager(
                  archivedOrProject: args.archivedOrProject,
                  fromProject: args.fromProject,
                ),
            settings: settings);
      case RouteConstants.crewPageProfileManager:
        return MaterialPageRoute(
            builder: (_) => const CrewProfilePageManager(), settings: settings);
      case RouteConstants.timeSheetScreenManager:
        final args = settings.arguments as TimeSheetsScreenManager;
        return MaterialPageRoute(
            builder: (_) => TimeSheetsScreenManager(
                  removeInterruption: args.removeInterruption,
                ),
            settings: settings);
      case RouteConstants.timeSheetsFromCrew:
        return MaterialPageRoute(
            builder: (_) => const TimeSheetFromCrew(), settings: settings);
      case RouteConstants.billingInformationPageManager:
        final args = settings.arguments as BillingInformationPageManager;
        return MaterialPageRoute(
            builder: (_) => BillingInformationPageManager(
                  texOrNot: args.texOrNot,
                ),
            settings: settings);
      case RouteConstants.paymentPageManager:
        return MaterialPageRoute(
            builder: (_) => const PaymentPageManager(), settings: settings);
      case RouteConstants.certificationPageManager:
        return MaterialPageRoute(
            builder: (_) => CertificationPageManager(),
            settings: settings);
      case RouteConstants.editProfilePageManager:
        return MaterialPageRoute(
            builder: (_) => const EditProfilePageManager(), settings: settings);
      case RouteConstants.changePasswordPageManager:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordPageManager(),
            settings: settings);

      case RouteConstants.autoComplete:
        return MaterialPageRoute(
            builder: (_) => CustomSearchScaffold(), settings: settings);

      case RouteConstants.resetPasswordScreenManager:
        final token = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreenManager(
                  authToken: token,
                ),
            settings: settings);

      case RouteConstants.showNotePageManager:
        return MaterialPageRoute(
            builder: (_) => ShowNotePageManager(noteData: args as manager_note.Note,), settings: settings);

      case RouteConstants.showNotePageCrew:
        return MaterialPageRoute(
            builder: (_) => ShowNotePageCrew(noteData: args as Note,), settings: settings);

      case RouteConstants.showCertificationManagerPage:
        return MaterialPageRoute(
            builder: (_) => ShowCertificateManagerPage(certificationData: args as manager_cert.Cert), settings: settings);

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
