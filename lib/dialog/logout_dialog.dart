import 'package:flutter/material.dart';
import 'package:gigpoint/screens/authentication/login_page.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.all(48),
      insetPadding: const EdgeInsets.all(16),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlineButtonWidget(
                name: 'Cancel',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ButtonWidget(
                name: 'Logout',
                onTap: () async {
                  await HiveHelper.clearUserSession();
                  pushNewScreen(
                    context,
                    screen: const LoginPage(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            )
          ],
        ),
      ],
      content: SizedBox(
        width: Constants.dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Logout',
              textAlign: TextAlign.center,
              style: Styles.semiBold(fontSize: 21),
            ),
            const SizedBox(height: 30),
            Text(
              'Are you sure you want to logout GigPoint app?',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
