import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/contactus/contactus_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CancelCard extends StatelessWidget {
  const CancelCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery by June 28',
              style: Styles.semiBold(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const ContactUsPage(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Text(
                  'Cancel Order',
                  style: Styles.semiBold(
                      fontSize: 16, color: AppTheme.primaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
