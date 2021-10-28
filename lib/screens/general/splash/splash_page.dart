import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/widgets/lottie_widget.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  bool isLogin = false;
  bool isTermsAndConditionsAccepted = false;

  @override
  void initState() {
    super.initState();
    initializeConfiguration();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ///Setup the necessary things before start the application.
  initializeConfiguration() async {
    ///Load Configuration file.
    Env.loadConfigFile().then((isLoaded) async {
      if (isLoaded) {
        ///GetIt Dependencies.
        configureDependencies();

        ///Initialize the Hive.
        await HiveHelper.initialize();

        ///Check if the user is login or not.
        isLogin =
            HiveHelper.loginBox.get(HiveConstants.login) == null ? false : true;

        ///Check if the user accepted the terms and conditions.
        if (isLogin) {
          isTermsAndConditionsAccepted = HiveHelper.loginBox
                  .get(HiveConstants.login)
                  ?.termsAndConditionsAccepted ??
              false;
        }

        getVersion();

        startTimer();
      }
    });
  }

  ///Get the current Version and Build Number
  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Env.BUILD_NUMBER = packageInfo.buildNumber;
    Env.BUILD_VERSION = packageInfo.version;
  }

  ///Start a timer of 2 sec before navigating to another page.
  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      ///Check if the user is logged in and accepts the terms and conditions.
      ///If user accepts the both, navigate to dashboard page.
      ///else navigate to Login page
      if (isLogin && isTermsAndConditionsAccepted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.dashboard, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.onboarding, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<bool>(
          future: Env.loadConfigFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.data!) {
              return const NoDataWidget(
                msg: Validations.CONFIGURATION_FILE_ERROR,
              );
            }
            return Container(
              alignment: Alignment.center,
              child: const LottieWidget(
                asset: LottieAnims.splashIcon,
                width: 164,
                height: 164,
              ),
            );
          }),
    );
  }
}
