import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/rewards/rewards_summary_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RewardPointsWidget extends StatelessWidget {
  const RewardPointsWidget({Key? key, required this.points}) : super(key: key);
  final double points;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          onTap: () {
            pushNewScreen(
              context,
              screen: const RewardsSummaryPage(initialIndex: 0),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          title: PointsWidget(
            points: points,
            fontSize: 22,
            iconSize: 25,
            pointsColor: AppTheme.textPrimaryColor,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'GigPoint Balance',
              style: Styles.semiBold(fontSize: 14),
            ),
          ),
          trailing: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
