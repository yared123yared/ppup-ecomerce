import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';

class AddressOptions extends StatelessWidget {
  const AddressOptions(
      {Key? key, this.onDeleteTap, this.onEditTap, this.onCloseTap})
      : super(key: key);
  final GestureTapCallback? onDeleteTap;
  final GestureTapCallback? onEditTap;
  final GestureTapCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onCloseTap,
              child: const Icon(
                Icons.close,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    name: 'Delete',
                    onTap: onDeleteTap,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ButtonWidget(
                    name: 'Edit',
                    onTap: onEditTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
