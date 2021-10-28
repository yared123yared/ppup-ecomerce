import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

import 'inc_dec_widget.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {Key? key,
      required this.onAddTap,
      required this.onRemoveTap,
      required this.quantity})
      : super(key: key);
  final GestureTapCallback onAddTap, onRemoveTap;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IncDecWidget(
          isAdd: false,
          onTap: onRemoveTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$quantity',
            style: Styles.semiBold(
                fontSize: 14, color: AppTheme.textSecondaryColor),
          ),
        ),
        IncDecWidget(
          isAdd: true,
          onTap: onAddTap,
        ),
      ],
    );
  }
}
