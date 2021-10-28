import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.value,
    this.groupValue,
    required this.onChanged,
    this.titleStyle,
  }) : super(key: key);

  final String title;
  final GestureTapCallback? onTap;
  final String value;
  final String? groupValue;
  final ValueChanged? onChanged;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            splashRadius: 0,
          ),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleStyle ?? Styles.semiBold(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
