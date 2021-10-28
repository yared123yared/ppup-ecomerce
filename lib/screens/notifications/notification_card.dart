import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SvgImage(
                        asset: Images.coin,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          'You have Earned 500 pts for 500 Deliveries',
                          style: Styles.semiBold(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  size: 24,
                  color: AppTheme.textSecondaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 55),
              child: Text(
                '02 June',
                style: Styles.semiBold(
                    fontSize: 10, color: AppTheme.textSecondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
