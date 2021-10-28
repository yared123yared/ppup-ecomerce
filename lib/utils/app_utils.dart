import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/loading_dialog.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class AppUtils {
  static showLoadingDialog(BuildContext context) {
    dialogBuilder(context, const LoadingDialog());
  }

  static dialogBuilder(BuildContext context, Widget dialog) {
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: dialog,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return dialog;
      },
    );
  }

  static openDriverApp() async {
    String _url = '';
    if (Platform.isAndroid) {
      _url = Constants.driverAppPlayStoreUrl;
    } else {
      _url = Constants.driverAppAppStoreUrl;
    }
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  static showErrorSnackbar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: Styles.semiBold(fontSize: 14, color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: AppTheme.errorColor,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static removeFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> makePhoneCall(String number) async {
    String _number = 'tel:$number';
    if (await canLaunch(_number)) {
      await launch(_number);
    } else {
      throw 'Could not launch $_number';
    }
  }

  static DateTime get getCurrentDate {
    DateTime dateTime = DateTime.now();
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
  }

  static DateTime get getWeeklyDate {
    DateTime currentDate = getCurrentDate;
    DateTime date = currentDate.subtract(Duration(days: currentDate.weekday));
    return dateWithoutTime(date);
  }

  static DateTime get getMonthlyDate {
    DateTime currentDate = getCurrentDate;
    return DateTime(currentDate.year, currentDate.month, 1);
  }

  static DateTime dateWithoutTime(DateTime date) => DateUtils.dateOnly(date);
}
