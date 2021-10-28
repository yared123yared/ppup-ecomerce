import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';

class PrimaryAddressDialog extends StatelessWidget {
  const PrimaryAddressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.all(48),
      insetPadding: const EdgeInsets.all(12),
      actions: [
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                name: 'Okay',
                onTap: () {
                  Navigator.pop(context);
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
              'Primary Address',
              textAlign: TextAlign.center,
              style: Styles.semiBold(fontSize: 21),
            ),
            const SizedBox(height: 30),
            Text(
              'You can’t edit/delete your primary address here.',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
