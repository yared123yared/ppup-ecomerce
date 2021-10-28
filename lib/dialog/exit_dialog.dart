import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

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
                name: 'Exit',
                onTap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
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
              'Exit',
              textAlign: TextAlign.center,
              style: Styles.semiBold(fontSize: 21),
            ),
            const SizedBox(height: 30),
            Text(
              'Are you sure you want to exit GigPoint app?',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
