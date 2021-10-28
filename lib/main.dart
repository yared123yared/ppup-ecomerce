import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/utils/constants.dart';

import 'screens/authentication/login_page.dart';
import 'screens/dashboard/dashboard_page.dart';
import 'screens/general/onboarding/onboarding_page.dart';
import 'screens/general/splash/splash_page.dart';
import 'screens/general/terms_conditions/terms_and_condtions_page.dart';
import 'utils/app_theme.dart';
import 'utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///Change the status bar color.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
  ));

  ///Set the device orientation to Portrait mode.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const GigPointApp());
}

final FirebaseAnalytics analytics = FirebaseAnalytics();
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class GigPointApp extends StatelessWidget {
  const GigPointApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.removeFocus();
      },
      child: BackGestureWidthTheme(
        backGestureWidth: BackGestureWidth.fraction(1 / 2),
        child: MaterialApp(
          title: 'GigPoint',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          navigatorKey: navKey,
          theme: ThemeData(
            primaryColor: AppTheme.primaryColor,
            accentColor: AppTheme.primaryColor,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppTheme.primaryColor,
            ),
            scaffoldBackgroundColor: AppTheme.scaffoldBackground,
            fontFamily: Constants.fontFamily,
            dividerColor: AppTheme.borderColor,
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 0)),
            )),
            cardTheme: CardTheme(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android:
                    CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
                TargetPlatform.iOS:
                    CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              },
            ),
          ),
          home: const SplashPage(),
          routes: {
            Routes.onboarding: (context) => const OnboardingPage(),
            Routes.login: (context) => const LoginPage(),
            Routes.dashboard: (context) => const DashboardPage(),
            Routes.termsAndConditions: (context) =>
                const TermsAndCondtionsPage(),
          },
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
