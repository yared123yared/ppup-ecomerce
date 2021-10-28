import 'package:flutter/material.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/strings.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class FirstTimeBonusDialog extends StatelessWidget {
  const FirstTimeBonusDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginClass login = HiveHelper.loginBox.get(HiveConstants.login)!;

    Future.delayed(const Duration(milliseconds: 2500), () async {
      login.isFirstTime = false;

      ///Save Login Data to local storage
      await HiveHelper.loginBox
          .put(HiveConstants.login, login)
          .then((value) => Navigator.of(context).pop(true));
    });
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        width: Constants.dialogWidth,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgImage(asset: Images.firstTimeBonus, height: 160),
            const SizedBox(height: 20),
            PointsWidget(
              points: login.firstTimeBonus ?? 0,
              fontSize: 24,
              iconSize: 24,
              pointsColor: AppTheme.textPrimaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: Text(
                welcomeToGigPointString,
                style: Styles.semiBold(fontSize: 20),
              ),
            ),
            Text(
              'Here\'s your ${login.firstTimeBonus?.toInt()} sign-up bonus points!',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
