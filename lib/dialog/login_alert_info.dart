import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';

class LoginAlertInfo extends StatelessWidget {
  const LoginAlertInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: SizedBox(
        width: Constants.dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close,
                        color: AppTheme.primaryColor, size: 24))),
            const Icon(
              Icons.info_outline,
              color: AppTheme.primaryColor,
              size: 66,
            ),
            const SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RichText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please enter the registered email with ',
                      style: Styles.semiBold(fontSize: 16),
                    ),
                    TextSpan(
                      text: 'Point Pickup Driver App',
                      style: Styles.bold(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            //const SizedBox(height: 35),
            //const Divider(color: AppTheme.borderColor, thickness: 1.5),
            //const SizedBox(height: 20),
            //Text(
            //'Need more help?',
            //textAlign: TextAlign.center,
            //style: Styles.semiBold(fontSize: 16),
            //),
            //const SizedBox(height: 20),
            // Row(
            // children: [
            // Expanded(
            //  flex: 2,
            // child: RichText(
            //text: TextSpan(
            // text: 'Email:\n',
            //style: Styles.regular(fontSize: 16),
            //children: [
            // TextSpan(
            // text: Env.SUPPORT_EMAIL,
            // style: Styles.semiBold(
            // fontSize: 16, color: AppTheme.primaryColor)),
            //]),
            // ),
            //),
            //Expanded(
            //child: RichText(
            //  text: TextSpan(
            //   text: '\t\tCall center:\n',
            // style: Styles.regular(fontSize: 16),
            //children: [
            // TextSpan(
            //    text: Env.SUPPORT_PHONE,
            //   style: Styles.semiBold(
            //     fontSize: 16, color: AppTheme.primaryColor)),
            //]),
            //),
            //  ),
            // ],
            // ),
            //const SizedBox(height: 40),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ButtonWidget(
                  name: 'Got It',
                  onTap: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
