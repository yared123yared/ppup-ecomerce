import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final GestureTapCallback? onTap;
  final double? width, height;
  final bool isActive;
  const ButtonWidget({
    Key? key,
    required this.name,
    required this.onTap,
    this.width = double.infinity,
    this.height = 60,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: ElevatedButton(
          onPressed: isActive ? onTap : null,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                isActive ? AppTheme.primaryColor : AppTheme.disabledColor),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          ),
          child: Text(
            name,
            style: Styles.bold(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
