import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    Key? key,
    required this.onChanged,
    required this.title,
    required this.onTap,
    this.value,
  }) : super(key: key);
  final ValueChanged<bool?> onChanged;
  final String title;
  final GestureTapCallback onTap;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Flexible(
            child: Text(
              title,
              style: Styles.semiBold(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
