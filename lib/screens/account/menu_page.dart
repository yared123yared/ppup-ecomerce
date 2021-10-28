import 'package:flutter/material.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/dialog/logout_dialog.dart';
import 'package:gigpoint/screens/account/faq/faq_page.dart';
import 'package:gigpoint/screens/general/terms_conditions/terms_and_condtions_page.dart';
import 'package:gigpoint/screens/home/profile_info_widget.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'address/address_page.dart';
import 'contactus/contactus_page.dart';
import 'notificationsetting/notification_setting_page.dart';
import 'purchases/purchases_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarWidget(title: 'Menu'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          'Version ${Env.BUILD_VERSION} (${Env.BUILD_NUMBER})',
          textAlign: TextAlign.center,
          style:
              Styles.semiBold(fontSize: 12, color: AppTheme.textSecondaryColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ProfileInfoWidget(showTrailing: false),
          const Divider(thickness: 1.2),
          itemWidget(
            icon: Icons.shopping_bag_outlined,
            title: 'My Purchases',
            onTap: () {
              pushNewScreen(
                context,
                screen: const PurchasesPage(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.place_outlined,
            title: 'My Addresses',
            onTap: () {
              pushNewScreen(
                context,
                screen: const AddressPage(isSelection: false),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.edit_notifications_outlined,
            title: 'Notification Settings',
            onTap: () {
              pushNewScreen(
                context,
                screen: const NotificationSettingPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.live_help_outlined,
            title: 'FAQ and Help',
            onTap: () {
              pushNewScreen(
                context,
                screen: const FaqPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.support_agent_outlined,
            title: 'Contact Us',
            onTap: () {
              pushNewScreen(
                context,
                screen: const ContactUsPage(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.assignment_outlined,
            title: 'Terms & Conditions',
            onTap: () {
              pushNewScreen(
                context,
                screen: const TermsAndCondtionsPage(isFirstTime: false),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          itemWidget(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onTap: () => showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget itemWidget({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Icon(
        icon,
        color: AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: Styles.semiBold(fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  void showLogoutDialog() {
    AppUtils.dialogBuilder(context, const LogoutDialog());
  }
}
