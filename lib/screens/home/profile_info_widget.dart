import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/cart/cart_bloc.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/cart/cart_page.dart';
import 'package:gigpoint/screens/notifications/notifications_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileInfoWidget extends StatelessWidget {
  final bool showTrailing;
  const ProfileInfoWidget({
    Key? key,
    this.showTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginClass? user = HiveHelper.loginBox.get(HiveConstants.login);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          const SvgImage(
            asset: Images.coin,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 8),
          Text(
            '${user?.firstName} ${user?.lastName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.bold(fontSize: 16),
          )
        ],
      ),
      trailing: showTrailing
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const NotificationsPage(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                    pushNewScreen(
                      context,
                      screen: const CartPage(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                              return (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty)
                                  ? Positioned(
                                      right: 0,
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          (snapshot.hasData)
                                              ? '${snapshot.data?.length}'
                                              : '0',
                                          style: Styles.semiBold(
                                              fontSize: 10,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            )
          : null,
    );
  }
}
