
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/app_state_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreference.prefs = await SharedPreferences.getInstance();
  // Set portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setUpLocator();
  await Future.delayed(const Duration(seconds: 2));
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
    ],
    path: 'assets/langs',
    fallbackLocale: const Locale('en'),

    child: ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: MyApp(),
    ),
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
        builder: (context, appState, _) {
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context , child) {
                return  MaterialApp(
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: SharedPreference.prefs!.getBool(SharedPreference.THEME_STATUS) == true ? ThemeMode.dark : ThemeMode.light,
                    // themeMode: ThemeMode.dark,
                    /* ThemeMode.system to follow system theme,
                      ThemeMode.light for light theme,
                       ThemeMode.dark for dark theme
                    */
                    debugShowCheckedModeBanner: false,
                    title: 'beehive'.tr(),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    // theme: ThemeData(
                    //   primarySwatch: color,
                    // ),
                    onGenerateRoute: router.OnGenerateRouter.onGenerate,
                    initialRoute: RouteConstants.beehiveIntro
                );
        });
      },
    );
  }

}

