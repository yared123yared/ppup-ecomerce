import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/lottie_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: SizedBox(
        width: Constants.dialogWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LottieWidget(
                asset: LottieAnims.splashIcon,
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 24),
              Text('Please wait for a moment…',
                  textAlign: TextAlign.center,
                  style: Styles.regular(fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
