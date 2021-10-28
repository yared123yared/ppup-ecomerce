import 'package:flutter/material.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

import 'empty_notification.dart';
import 'notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Notifications',
        actions: [],
      ),
      body: 1 == 1
          ? const EmptyNotificationPage()
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) => const NotificationCard(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: 5,
                ),
              ],
            ),
    );
  }
}








// Card(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 18, top: 24, right: 29),
//                 child: SvgImage(asset: Images.coin, height: 24, width: 24),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 11),
//                       child: Text(
//                         'You have Earned 500 pts for 500 Deliveries',
//                         style: Styles.semiBold(fontSize: 16),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4, bottom: 10),
//                       child: Text(
//                         '02 June',
//                         style: Styles.semiBold(
//                             fontSize: 10, color: AppTheme.textSecondaryColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 child: Icon(
//                   Icons.more_vert,
//                   size: 24,
//                   color: AppTheme.textSecondaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
