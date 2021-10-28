import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class MoreTrackPackage extends StatelessWidget {
  const MoreTrackPackage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 38),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.primaryColor),
                ),
                const SizedBox(
                  height: 72,
                  child: VerticalDivider(
                    thickness: 2,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.primaryColor),
                ),
                const SizedBox(
                  height: 71,
                  child: VerticalDivider(
                    thickness: 2,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.primaryColor),
                ),
              ],
            ),
            const SizedBox(
              width: 12,
              // height: 33,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 33),
                  Text(
                    'Order Placed',
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your order has been placed successfuly Mon, 21 May 2021',
                    style: Styles.regular(fontSize: 12),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Shipping Status',
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your order has been placed successfuly Mon, 21 May 2021',
                    style: Styles.regular(fontSize: 12),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Delivery Status',
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your order has been placed successfuly Mon, 21 May 2021',
                    style: Styles.regular(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 38),
        TextButton(
            onPressed: () {},
            child: Text(
              'Track Shipment',
              style:
                  Styles.semiBold(fontSize: 14, color: AppTheme.primaryColor),
            ))
      ],
    );
  }
}
