import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/screens/authentication/login_page.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

@lazySingleton
class ErrorHandlerBloc {
  var subject = BehaviorSubject.seeded(false);
  Stream<bool> get responseData => subject.stream;

  bool isSessionExpired = false;

  navigateToLogin() async {
    if (!isSessionExpired) {
      ///Clear Local Storage.
      await HiveHelper.clearUserSession();

      ///Navigate to Login.
      pushNewScreen(
        navKey.currentContext!,
        screen: const LoginPage(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );

      ///Show Error Snackbar.
      AppUtils.showErrorSnackbar(
          navKey.currentContext!, Validations.SESSION_EXPIRY);
      isSessionExpired = true;
      subject.sink.add(isSessionExpired);
    }
  }

  resetSessionValue() {
    isSessionExpired = false;
    subject.sink.add(isSessionExpired);
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
