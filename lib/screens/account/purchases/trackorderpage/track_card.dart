import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/more_track_package.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class TrackCard extends StatefulWidget {
  const TrackCard({
    Key? key,
  }) : super(key: key);

  @override
  _TrackCardState createState() => _TrackCardState();
}

class _TrackCardState extends State<TrackCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Track Package',
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 26,
                    color: AppTheme.primaryColor,
                  )
                ],
              ),
            ),
            if (isExpanded) const MoreTrackPackage(),
            const SizedBox(height: 34),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(height: 26),
            Text(
              'Need more help?',
              style: Styles.semiBold(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
