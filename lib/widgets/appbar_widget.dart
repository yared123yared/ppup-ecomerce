import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/cart/cart_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/cart/cart_page.dart';
import 'package:gigpoint/screens/notifications/notifications_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget(
      {Key? key, required this.title, this.actions, this.leading})
      : super(key: key);

  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: Styles.bold(fontSize: 18),
      ),
      leading: leading,
      iconTheme: const IconThemeData(color: AppTheme.primaryColor),
      actions: actions ??
          [
            GestureDetector(
              onTap: () {
                AppUtils.removeFocus();
                pushNewScreen(
                  context,
                  screen: const NotificationsPage(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                AppUtils.removeFocus();
                pushNewScreen(
                  context,
                  screen: const CartPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Center(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppTheme.primaryColor,
                    ),
                    StreamBuilder<List<Product>>(
                        stream: getIt<CartBloc>().responseData,
                        builder: (context, snapshot) {
                          return (snapshot.hasData && snapshot.data!.isNotEmpty)
                              ? Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      (snapshot.hasData)
                                          ? snapshot.data!.length >= 10
                                              ? '9+'
                                              : '${snapshot.data?.length}'
                                          : '0',
                                      style: Styles.semiBold(
                                          fontSize: 10, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
