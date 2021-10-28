import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/contactus/contactus_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OrderInfoCard extends StatefulWidget {
  final int? orderStatus;
  const OrderInfoCard({Key? key, this.orderStatus}) : super(key: key);

  @override
  State<OrderInfoCard> createState() => _OrderInfoCardState();
}

class _OrderInfoCardState extends State<OrderInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                rowWidget('Order Date', '20th June'),
                const SizedBox(height: 10),
                rowWidget('Order No', 'HGWJ-VBWHJ-124'),
                const SizedBox(height: 10),
                rowWidget('Order Total', '1000'),
                const SizedBox(height: 10),
                rowWidget('Cancelled on', '28th June'),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1.2,
            color: AppTheme.textSecondaryColor.withOpacity(0.1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const ContactUsPage(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Text(
                    'Need Help?',
                    style: Styles.semiBold(
                        fontSize: 16, color: AppTheme.primaryColor),
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      widget.orderStatus == 0
                          ? 'Cancel Order'
                          : widget.orderStatus == 1
                              ? 'Order Again'
                              : widget.orderStatus == 2
                                  ? 'Order Again'
                                  : widget.orderStatus == 3
                                      ? 'Return Order'
                                      : '',
                      style: Styles.semiBold(
                          fontSize: 16, color: AppTheme.primaryColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowWidget(String title, String value) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Styles.semiBold(
                  fontSize: 16, color: AppTheme.textSecondaryColor),
            ),
          ),
          if (title != 'Order Total')
            Expanded(
              child: Text(
                value,
                style: Styles.semiBold(fontSize: 16),
              ),
            ),
          if (title == 'Order Total')
            const Expanded(
              child: PointsWidget(
                points: 0,
                fontSize: 16,
                iconSize: 16,
                pointsColor: AppTheme.textPrimaryColor,
              ),
            )
        ],
      );
}
