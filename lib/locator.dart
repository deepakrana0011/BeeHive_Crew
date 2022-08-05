import 'package:beehive/provider/add_note_page_provider.dart';
import 'package:beehive/provider/app_settings_provider.dart';
import 'package:beehive/provider/app_state_provider.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/bottom_bar_provider.dart';
import 'package:beehive/provider/certification_page_provider.dart';
import 'package:beehive/provider/dashboard_provider.dart';
import 'package:beehive/provider/edit_profile_provider.dart';
import 'package:beehive/provider/introduction_provider.dart';
import 'package:beehive/provider/project_details_provider.dart';
import 'package:beehive/provider/project_settings_provider.dart';
import 'package:beehive/provider/projects_provider.dart';
import 'package:beehive/provider/sign_in_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){

  locator.registerFactory<IntroductionProvider>(() => IntroductionProvider());
  locator.registerFactory<SignInProvider>(() => SignInProvider());
  locator.registerFactory<BottomBarProvider>(() => BottomBarProvider());
  locator.registerFactory<AppStateNotifier>(() => AppStateNotifier());
  locator.registerFactory<DashboardProvider>(() => DashboardProvider());
  locator.registerFactory<AppSettingsProvider>(() => AppSettingsProvider());
  locator.registerFactory<BaseProvider>(() => BaseProvider());
  locator.registerFactory(() => ProjectsProvider());
  locator.registerFactory(() => BaseProvider());
  locator.registerFactory(() => ProjectDetailsPageProvider());
  locator.registerFactory(() => AddNotePageProvider());
  locator.registerFactory(() => ProjectSettingsProvider());
  locator.registerFactory(() => EditProfileProvider());
  locator.registerFactory(() => CertificationPageProvider());
}