import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/contactus/contactus_page.dart';
import 'package:gigpoint/screens/account/faq/banking_faq_tab.dart';
import 'package:gigpoint/screens/account/faq/insurance_fab_ta.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'rewards_and_shop_faq_tab.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: const AppbarWidget(title: 'Help & Support'),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: AppTheme.boxShadow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Need more help?',
                  style: Styles.semiBold(fontSize: 18),
                ),
                TextButton.icon(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const ContactUsPage(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  icon: Text(
                    'Contact US',
                    style: Styles.semiBold(
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  label: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.cardBackgroundColor,
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelStyle: Styles.semiBold(
                        fontSize: 14, color: AppTheme.primaryColor),
                    unselectedLabelStyle: Styles.semiBold(fontSize: 14),
                    unselectedLabelColor: Colors.black,
                    labelColor: AppTheme.primaryColor,
                    indicatorColor: AppTheme.primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      const Tab(child: Text('REWARDS & SHOP')),
                      const Tab(child: Text('BANKING')),
                      const Tab(child: Text('INSURANCE')),
                    ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: TabBarView(
                    controller: _controller,
                    children: const [
                      RewardsAndShopFAQTab(),
                      BankingFAQTab(),
                      InsuranceFAQTab(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
