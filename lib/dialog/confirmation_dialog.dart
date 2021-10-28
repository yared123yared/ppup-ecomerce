import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(context),
      child: AlertDialog(
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close,
                          color: AppTheme.primaryColor, size: 24))),
              const Icon(
                Icons.check_circle_outline_rounded,
                color: AppTheme.primaryColor,
                size: 66,
              ),
              const SizedBox(height: 19),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Your request has been successfully received. Our support team shall reach out to you shortly.',
                  textAlign: TextAlign.center,
                  style: Styles.semiBold(fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ButtonWidget(
                    name: 'Got It',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    return Future.value(false);
  }
}
