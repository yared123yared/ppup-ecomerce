import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/earn/earn_activity.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/strings.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

class EarnPage extends StatefulWidget {
  const EarnPage({Key? key}) : super(key: key);

  @override
  _EarnPageState createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  List<bool> isExpanded = [];

  @override
  void initState() {
    super.initState();
    isExpanded = List.generate(data.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Earning Activities',
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    pointPickupDriverAppString,
                    style: Styles.semiBold(
                        fontSize: 16, color: AppTheme.textSecondaryColor),
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      AppUtils.openDriverApp();
                    },
                    icon: Text(
                      'Driver App',
                      style: Styles.semiBold(
                          fontSize: 14, color: AppTheme.primaryColor),
                    ),
                    label: const Icon(
                      Icons.open_in_new,
                      color: AppTheme.primaryColor,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: data.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemBuilder: (context, index) => EarnActivity(
                data: data[index],
                onPressed: () {
                  setState(() {
                    isExpanded[index] = !isExpanded[index];
                  });
                },
                isExpanded: isExpanded[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EarnData {
  final String title;
  final String desc;
  final String image;
  final double points;
  final List<String> criteria;

  EarnData({
    required this.title,
    required this.desc,
    required this.image,
    required this.points,
    required this.criteria,
  });
}

final List<EarnData> data = [
  EarnData(
      title: 'Completed Gigs',
      desc: 'Earn one point for every successful delivery.',
      image: Images.normal,
      points: 01,
      criteria: [
        'Delivery has to be successfully dropped off with the customer',
        'Returns to the store will not count as a successful delivery'
      ]),
  EarnData(
      title: 'Holiday Gigs',
      desc: 'Earn 15 points per order for delivering on designated holidays.',
      image: Images.holiday,
      points: 15,
      criteria: [
        'New Year’s Eve, New Year’s Day, SuperBowl Sunday, Easter Sunday, Memorial Day, July 4th, Labor Day, Thanksgiving, Black Friday, Christmas Eve, Christmas Day',
      ]),
  EarnData(
      title: 'Weekend Gigs',
      desc:
          'Earn 5 points for completing deliveries on a consecutive Saturday and Sunday',
      image: Images.weekend,
      points: 05,
      criteria: [
        'Complete at least one delivery daily on a Saturday and Sunday of the same weekend',
      ]),
  EarnData(
      title: 'On-Time Delivery',
      desc:
          'Earn 5 points for completing a delivery before the designated drop-off time',
      image: Images.onTime,
      points: 05,
      criteria: [
        'Complete the dropoff checklist and mark ’Complete Delivery’ before the designated drop-off time.',
      ]),
  EarnData(
      title: 'Peak-Hour Gig',
      desc: 'Earn 10 points for successful peak-hour deliveries',
      image: Images.peakHour,
      points: 10,
      criteria: [
        'Peak-hour times are determined by Point Pickup’s operating system',
        'Updates are coming to the Point Pickup driver system to allow you to identify peak-hour orders'
      ]),
  EarnData(
      title: 'On-Time Arrival',
      desc:
          'Earn 3 points for arriving at the store before the designated pickup time',
      image: Images.onTimeArrival,
      points: 03,
      criteria: [
        'Mark ’Arrived at Pickup’ in the Point Pickup Driver App before the pickup time',
      ]),
  EarnData(
      title: 'Point Trust Bank Account',
      desc: 'Earn 100 points for opening a Point Trust Bank Account',
      image: Images.pointTrustBank,
      points: 100,
      criteria: [
        'Receive points for opening a Point Trust Bank Account',
      ]),
  EarnData(
      title: 'Point Insurance Plan',
      desc: 'Earn 100 points for purchasing your first Point Insurance plan',
      image: Images.pointInsuranceplan,
      points: 100,
      criteria: [
        'Receive points for the first Point Insurance plan you purchase. Discludes any subsequent plans purchased.',
      ]),
];
