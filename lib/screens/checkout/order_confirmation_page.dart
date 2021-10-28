import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/screens/dashboard/dashboard_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  Future<bool> willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (BuildContext context) {
          return const DashboardPage(index: 0);
        },
      ),
      (_) => false,
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: const AppbarWidget(
              title: 'Order Confirmation',
              actions: [],
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: AppTheme.boxShadow,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlineButtonWidget(
                      name: 'Goto Home',
                      onTap: () => willPopCallback(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: ButtonWidget(
                    name: 'My Purchases',
                    onTap: () {},
                  ))
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  const SvgImage(
                    asset: Images.check,
                    width: 65,
                    height: 65,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Transaction Successful',
                    style: Styles.bold(fontSize: 22),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Yay! You have successfully completed the purchase',
                    textAlign: TextAlign.center,
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'GigPoint Balance after Transaction',
                    style: Styles.semiBold(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const PointsWidget(
                    text: '',
                    points: 30000,
                    fontSize: 26,
                    iconSize: 27,
                    pointsColor: AppTheme.textPrimaryColor,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
