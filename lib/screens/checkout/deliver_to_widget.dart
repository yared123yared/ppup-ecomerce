import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/address/address_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DeliverToWidget extends StatelessWidget {
  const DeliverToWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DELIVER TO',
              style: Styles.bold(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Tim Koorbusch',
              style: Styles.bold(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'East Coast, New England, Northeastern US -544678',
              style: Styles.semiBold(fontSize: 14),
            ),
            // const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const AddressPage(isSelection: true),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                'Change Or Add Address',
                style: Styles.bold(fontSize: 14, color: AppTheme.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
