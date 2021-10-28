import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingPageState createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    isSelected = HiveHelper.notification.get('notification') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Notification Settings',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 39),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Notifications',
                      style: Styles.bold(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isSelected ? 'ON' : 'OFF',
                      // '${isSelected ? "ON" : "OFF"}',
                      style: Styles.semiBold(
                          fontSize: 14, color: AppTheme.primaryColor),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        value: isSelected,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) async {
                          setState(() {
                            isSelected = val;
                          });
                          await HiveHelper.notification
                              .put('notification', isSelected);
                        }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
