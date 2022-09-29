import 'package:beehive/model/create_project_request.dart';
import 'package:beehive/model/email_verified_response_manager.dart';
import 'package:beehive/provider/add_crew_page_provider_manager.dart';
import 'package:beehive/provider/add_note_page_manager_provider.dart';
import 'package:beehive/provider/add_note_page_provider.dart';
import 'package:beehive/provider/app_settings_provider.dart';
import 'package:beehive/provider/app_state_provider.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/bottom_bar_provider.dart';
import 'package:beehive/provider/certification_page_provider.dart';
import 'package:beehive/provider/certification_page_provider_manager.dart';
import 'package:beehive/provider/change_password_manager_provider.dart';
import 'package:beehive/provider/continue_with_phone_manager_provider.dart';
import 'package:beehive/provider/continue_with_phone_provider.dart';
import 'package:beehive/provider/create_project_manager_provider.dart';
import 'package:beehive/provider/crew_member_add_by_manager_provider.dart';
import 'package:beehive/provider/crew_profile_page_provider_manager.dart';
import 'package:beehive/provider/dashboard_page_manager_provider.dart';
import 'package:beehive/provider/dashboard_provider.dart';
import 'package:beehive/provider/drawer_manager_provider.dart';
import 'package:beehive/provider/edit_profile_provider.dart';
import 'package:beehive/provider/email_address_manager_provider.dart';
import 'package:beehive/provider/email_address_screen_provider.dart';
import 'package:beehive/provider/introduction_provider.dart';
import 'package:beehive/provider/login_manager_provider.dart';
import 'package:beehive/provider/notification_provider.dart';
import 'package:beehive/provider/login_provider.dart';
import 'package:beehive/provider/otp_page_provider.dart';
import 'package:beehive/provider/otp_page_verification_manager.dart';
import 'package:beehive/provider/profile_page_manager_provider.dart';
import 'package:beehive/provider/profile_page_provider.dart';
import 'package:beehive/provider/project_crew_provider.dart';
import 'package:beehive/provider/project_details_manager_provider.dart';
import 'package:beehive/provider/project_details_provider.dart';
import 'package:beehive/provider/project_settings_manager_provider.dart';
import 'package:beehive/provider/project_settings_provider.dart';
import 'package:beehive/provider/projects_manager_provider.dart';
import 'package:beehive/provider/reset_password_manager_provider.dart';
import 'package:beehive/provider/reset_password_provider.dart';
import 'package:beehive/provider/set_rates_page_manager_provider.dart';
import 'package:beehive/provider/sign_in_provider.dart';
import 'package:beehive/provider/sign_up_manager_provider.dart';
import 'package:beehive/provider/sign_up_provider.dart';
import 'package:beehive/provider/time_sheet_provider_crew.dart';
import 'package:beehive/provider/timesheet_from_crew_provider.dart';
import 'package:beehive/provider/timesheet_manager_provider.dart';
import 'package:beehive/services/api_class.dart';
import 'package:beehive/widget/custom_class.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory<IntroductionProvider>(() => IntroductionProvider());
  locator.registerFactory<SignInProvider>(() => SignInProvider());
  locator.registerFactory<BottomBarProvider>(() => BottomBarProvider());
  locator.registerFactory<AppStateNotifier>(() => AppStateNotifier());
  locator.registerFactory<DashboardProvider>(() => DashboardProvider());
  locator.registerFactory<AppSettingsProvider>(() => AppSettingsProvider());
  locator.registerFactory<BaseProvider>(() => BaseProvider());
  locator.registerFactory<SignUpProvider>(() => SignUpProvider());
  locator.registerFactory<DrawerManagerProvider>(() => DrawerManagerProvider());
  locator.registerFactory<LoginProvider>(() => LoginProvider());
  locator.registerFactory<ResetPasswordProvider>(() => ResetPasswordProvider());
  locator.registerFactory<DashBoardPageManagerProvider>(
      () => DashBoardPageManagerProvider());
  locator.registerFactory<BottomBarManagerProvider>(
      () => BottomBarManagerProvider());
  locator.registerFactory(() => ProjectsManagerProvider());
  locator.registerFactory(() => CustomClass());
  locator.registerFactory(() => ProjectDetailsPageProvider());
  locator.registerFactory(() => TimeSheetTabBarProviderCrew());
  locator.registerFactory(() => AddNotePageProvider());
  locator.registerFactory(() => ProjectSettingsProvider());
  locator.registerFactory(() => EditProfileProvider());
  locator.registerFactory(() => CertificationPageProvider());
  locator.registerFactory(() => NotificationProvider());
  locator.registerFactory(() => ContinueWithPhoneProvider());
  locator.registerFactory(() => SignUpManagerProvider());
  locator.registerFactory(() => ResetPasswordManagerProvider());
  locator.registerFactory(() => LoginManagerProvider());
  locator.registerFactory(() => ProjectDetailsManagerProvider());
  locator.registerFactory(() => CreateProjectManagerProvider());
  locator.registerFactory(() => CrewMemberAddByManagerProvider());
  locator.registerFactory(() => AddCrewPageManagerProvider());
  locator.registerFactory(() => SetRatesPageManageProvider());
  locator.registerFactory(() => ProjectSettingsManagerProvider());
  locator.registerFactory(() => AddNotePageManagerProvider());
  locator.registerFactory(() => CrewProfilePageProviderManager());
  locator.registerFactory(() => TimeSheetManagerProvider());
  locator.registerFactory(() => TimeSheetFromCrewProvider());
  locator.registerFactory(() => CertificationPageProviderManager());
  locator.registerFactory(() => ProfilePageManagerProvider());
  locator.registerFactory(() => OtpPageProvider());
  locator.registerFactory(() => OtpPageProviderManager());
  locator.registerFactory(() => ContinueWithPhoneManagerProvider());
  locator.registerFactory(() => EmailAddressScreenManagerProvider());
  locator.registerFactory(() => EmailAddressScreenProvider());
  locator.registerFactory(() => ProfilePageProvider());
  locator.registerFactory(() => ProjectsCrewProvider());
  locator.registerFactory<ChangePasswordManagerProvider>(() => ChangePasswordManagerProvider());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => CreateProjectRequest());
  locator.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        request: true,
        requestHeader: false,
        responseHeader: false));
    return dio;
  });
}
