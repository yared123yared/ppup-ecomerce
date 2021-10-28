import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class EmptyNotificationPage extends StatelessWidget {
  const EmptyNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgImage(
              asset: Images.emptyNotification,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 35),
            Text(
              'No Notifications Yet!',
              style: Styles.bold(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              'When you will get the notifications, They’ll show up here',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
