import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';

class DeleteAddressDialog extends StatelessWidget {
  const DeleteAddressDialog({Key? key, required this.onTap}) : super(key: key);
  final GestureTapCallback onTap;

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
                name: 'Not Now',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ButtonWidget(
                name: 'Yes, Delete',
                onTap: onTap,
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
              'Delete?',
              textAlign: TextAlign.center,
              style: Styles.semiBold(fontSize: 21),
            ),
            const SizedBox(height: 30),
            Text(
              'Are you sure you want to delete this item from your account?',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
