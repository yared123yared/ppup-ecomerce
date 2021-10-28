import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String name;
  final GestureTapCallback? onTap;
  final double? width, height;
  const OutlineButtonWidget(
      {Key? key,
      required this.name,
      required this.onTap,
      this.width = double.infinity,
      this.height = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0, right: 2),
        child: OutlinedButton(
          onPressed: onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            side: MaterialStateProperty.all(
              const BorderSide(color: AppTheme.primaryColor),
            ),
          ),
          child: Text(
            name,
            style: Styles.bold(fontSize: 16, color: AppTheme.primaryColor),
          ),
        ),
      ),
    );
  }
}
