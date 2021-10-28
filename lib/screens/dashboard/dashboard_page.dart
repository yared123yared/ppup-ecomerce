import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/cart/cart_bloc.dart';
import 'package:gigpoint/bloc/get_balance_bloc.dart';
import 'package:gigpoint/bloc/get_rewards_summary_bloc.dart';
import 'package:gigpoint/bloc/render_widget_bloc.dart';
import 'package:gigpoint/dialog/exit_dialog.dart';
import 'package:gigpoint/screens/account/menu_page.dart';
import 'package:gigpoint/screens/home/home_page.dart';
import 'package:gigpoint/screens/insurance/insurance_page.dart';
import 'package:gigpoint/screens/shop/shop_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../banking/banking_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, this.index = 0}) : super(key: key);
  final int index;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

late PersistentTabController controller;

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const BankingPage(),
      const InsurancePage(),
      const ShopPage(),
      const MenuPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      navItem(
        title: 'Home',
        icon: Icons.home_outlined,
      ),
      navItem(
        icon: Icons.account_balance_outlined,
        title: 'Banking',
      ),
      navItem(
        icon: Icons.verified_user_outlined,
        title: 'Insurance',
      ),
      navItem(
        icon: Icons.shopping_bag_outlined,
        title: 'Shop',
      ),
      navItem(
        icon: Icons.menu_outlined,
        title: 'Menu',
      ),
    ];
  }

  PersistentBottomNavBarItem navItem(
      {required String title, required IconData icon}) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: (title),
      textStyle: Styles.semiBold(fontSize: 12),
      activeColorPrimary: AppTheme.primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    );
  }

  GetBalanceBloc getBalanceBloc = getIt<GetBalanceBloc>();

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: widget.index);
    getBalanceBloc.getBalance();
    getIt<CartBloc>().getCart();

    ///Call the Reward Summary API for checking the first time user.
    ///To display graph or not.
    getIt<GetRewardSummaryBloc>().getRewardSummaryPoints(
        AppUtils.getCurrentDate, AppUtils.getWeeklyDate,
        type: 'weekly');
  }

  @override
  void dispose() {
    getBalanceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getIt<GraphQLApiClient>().client,
      child: CacheProvider(
        child: Scaffold(
          body: PersistentTabView(
            context,
            controller: controller,
            padding: const NavBarPadding.symmetric(vertical: 10),
            navBarHeight: 60,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            onItemSelected: (index) {
              getIt<RenderWidgetBloc>().render(index);
              if (index != 0) {
                getBalanceBloc.getBalance(isHome: true);
              }
            },
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: false, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: const NavBarDecoration(
              colorBehindNavBar: Colors.white,
              boxShadow: AppTheme.boxShadow,
            ),
            onWillPop: willPopCallback,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style6, // Choose the nav bar style with this property.
          ),
        ),
      ),
    );
  }

  Future<bool> willPopCallback(BuildContext? _context) async {
    if (controller.index == 0) {
      AppUtils.dialogBuilder(context, const ExitDialog());
    }
    return Future.value(true);
  }
}
