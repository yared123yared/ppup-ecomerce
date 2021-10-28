import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/bullet_points_widget.dart';

class MoreContent extends StatelessWidget {
  const MoreContent({Key? key, required this.criteria}) : super(key: key);
  final List<String> criteria;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Criteria',
            style: Styles.bold(fontSize: 14),
          ),
          const SizedBox(height: 10),
          BulletPointsWidget(points: criteria, isScondaryColor: true),
        ],
      ),
    );
  }
}
