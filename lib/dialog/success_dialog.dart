import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
              splashRadius: 1,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: AppTheme.primaryColor))),
      content: SizedBox(
        width: Constants.dialogWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SvgImage(asset: Images.success, width: 66, height: 66),
              const SizedBox(height: 20),
              Text(
                'Check Your Email',
                textAlign: TextAlign.center,
                style: Styles.bold(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                'We have sent a password recover instructions to your email.',
                textAlign: TextAlign.center,
                style: Styles.regular(fontSize: 16),
              ),
              const SizedBox(height: 50),
              ButtonWidget(
                  name: 'Okay',
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
